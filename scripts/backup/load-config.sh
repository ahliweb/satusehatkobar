#!/usr/bin/env bash
# Load backup configuration - sourced by other scripts
# Usage: source scripts/backup/load-config.sh
#
# This script reads from .backup-config or decrypts .backup-config.age temporarily.
# It also safely overlays local .env files when present.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG_FILE="$SCRIPT_DIR/.backup-config"
ENCRYPTED_FILE="$SCRIPT_DIR/.backup-config.age"

_trim() {
    local value="$1"
    value="${value#${value%%[!$' \t']*}}"
    value="${value%${value##*[!$' \t']}}"
    printf '%s' "$value"
}

_set_alias_if_unset() {
    local target="$1"
    local source="$2"
    [ -n "$target" ] || return 0
    [ -n "$source" ] || return 0

    if [ -z "${!target+x}" ] && [ -n "${!source:-}" ]; then
        printf -v "$target" '%s' "${!source}"
        export "$target"
    fi
}

_load_env_file() {
    local env_file="$1"
    [ -f "$env_file" ] || return 0

    while IFS= read -r raw_line || [ -n "$raw_line" ]; do
        local line="${raw_line%$'\r'}"

        case "$line" in
            ""|'#'*) continue ;;
            export\ *) line="${line#export }" ;;
        esac

        case "$line" in
            *=*) ;;
            *) continue ;;
        esac

        local key="${line%%=*}"
        local value="${line#*=}"

        key="$(_trim "$key")"
        value="$(_trim "$value")"

        case "$key" in
            ''|*[!A-Za-z0-9_]*|[0-9]*) continue ;;
        esac

        case "$key" in
            GITLAB_USERNAME|GITLAB_REPO_NAME|GITLAB_PAT|GITLAB_TOKEN|GITHUB_PAT|GITHUB_TOKEN|BACKUP_PASSPHRASE|CLOUDFLARE_API_TOKEN|CLOUDFLARE_ACCOUNT_ID|D1_DATABASE_NAME|R2_BUCKET_NAME|BACKUP_CRON_SCHEDULE|BACKUP_CONTENT|BACKUP_SSH_KEYS|BACKUP_GPG_KEYS|BACKUP_CLOUD_CREDS|NOTIFICATION_METHOD|GITLAB_REPO_URL|GITLAB_VISIBILITY|GITLAB_SSH_KEY_PATH|GITHUB_REPO_URL|GITHUB_BRANCH|ENCRYPTION_TOOL|LOCAL_BACKUP_DIR|BACKUP_LOG_FILE|GITHUB_ACTION_DEPLOY_WORKFLOW|GITHUB_ACTION_BACKUP_WORKFLOW|GITHUB_ACTION_MIRROR_WORKFLOW|GITHUB_ACTION_DEPLOY_BRANCH|GITHUB_ACTION_BACKUP_CRON|GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE|GITHUB_ACTION_NODE_VERSION|GITHUB_ACTION_PNPM_VERSION|CLOUDFLARE_WORKER_NAME|CLOUDFLARE_WORKER_MAIN|CLOUDFLARE_WORKER_COMPATIBILITY_DATE|CLOUDFLARE_WORKER_COMPATIBILITY_FLAGS|CLOUDFLARE_WORKER_PLACEMENT_MODE|CLOUDFLARE_WORKER_ROUTE_PATTERN|CLOUDFLARE_WORKER_ZONE_NAME|CLOUDFLARE_WORKER_CUSTOM_DOMAIN|CLOUDFLARE_WORKER_OBSERVABILITY|CLOUDFLARE_WORKER_D1_BINDING|CLOUDFLARE_WORKER_D1_DATABASE_NAME|CLOUDFLARE_WORKER_D1_DATABASE_ID|CLOUDFLARE_WORKER_R2_BINDING|CLOUDFLARE_WORKER_R2_BUCKET_NAME|CLOUDFLARE_WORKER_KV_BINDING|CLOUDFLARE_WORKER_KV_NAMESPACE_ID|CLOUDFLARE_WORKER_IMAGE_BINDING|CLOUDFLARE_WORKER_LOADER_BINDING|CLOUDFLARE_WORKER_SITE_URL|CLOUDFLARE_WORKER_STORAGE_PUBLIC_BASE_URL|ss_kobar_*)
                if [ -z "${!key+x}" ]; then
                    case "$value" in
                        '"'*'"') value="${value:1:-1}" ;;
                        "'"*"'") value="${value:1:-1}" ;;
                    esac
                    printf -v "$key" '%s' "$value"
                    export "$key"
                fi
                ;;
        esac
    done < "$env_file"
}

_load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        set -a
        source "$CONFIG_FILE"
        set +a
        return 0
    fi

    if [ -f "$ENCRYPTED_FILE" ]; then
        # Decrypt to temp file, source, then cleanup
        local temp_config
        temp_config=$(mktemp /tmp/awcms-config.XXXXXX)

        # Check if running interactively
        if [ -t 0 ]; then
            read -s -p "Backup config passphrase: " BACKUP_PASSPHRASE_INPUT
            echo
            echo "$BACKUP_PASSPHRASE_INPUT" | age --passphrase --decrypt --output "$temp_config" "$ENCRYPTED_FILE" 2>/dev/null
        else
            # Non-interactive: use BACKUP_PASSPHRASE env var
            if [ -z "${BACKUP_PASSPHRASE:-}" ]; then
                echo "Error: BACKUP_PASSPHRASE env var required for non-interactive config load" >&2
                rm -f "$temp_config"
                return 1
            fi
            echo "$BACKUP_PASSPHRASE" | age --passphrase --decrypt --output "$temp_config" "$ENCRYPTED_FILE" 2>/dev/null
        fi

        if [ -f "$temp_config" ] && grep -q '=' "$temp_config" 2>/dev/null; then
            set -a
            source "$temp_config"
            set +a
            rm -f "$temp_config"
            return 0
        else
            rm -f "$temp_config"
            echo "Error: Failed to decrypt backup config" >&2
            return 1
        fi
    fi

    echo "Error: No backup config found. Run: cp $SCRIPT_DIR/.backup-config.example $CONFIG_FILE" >&2
    return 1
}

_load_config

_load_env_file "$ROOT_DIR/.env"
_load_env_file "$ROOT_DIR/awcmsmicro-dev/.env"

_set_alias_if_unset GITLAB_USERNAME ss_kobar_gitlab_username
_set_alias_if_unset GITLAB_REPO_NAME ss_kobar_gitlab_repo_name
_set_alias_if_unset GITLAB_PAT ss_kobar_gitlab_pat
_set_alias_if_unset GITLAB_VISIBILITY ss_kobar_gitlab_visibility
_set_alias_if_unset GITLAB_SSH_KEY_PATH ss_kobar_gitlab_ssh_key_path
_set_alias_if_unset GITHUB_PAT ss_kobar_github_pat
_set_alias_if_unset CLOUDFLARE_API_TOKEN ss_kobar_cloudflare_api_token
_set_alias_if_unset CLOUDFLARE_ACCOUNT_ID ss_kobar_cloudflare_account_id
_set_alias_if_unset D1_DATABASE_NAME ss_kobar_backup_d1_database_name
_set_alias_if_unset R2_BUCKET_NAME ss_kobar_backup_r2_bucket_name
_set_alias_if_unset BACKUP_PASSPHRASE ss_kobar_backup_passphrase
_set_alias_if_unset BACKUP_CRON_SCHEDULE ss_kobar_backup_cron_schedule
_set_alias_if_unset BACKUP_CONTENT ss_kobar_backup_content
_set_alias_if_unset BACKUP_SSH_KEYS ss_kobar_backup_ssh_keys
_set_alias_if_unset BACKUP_GPG_KEYS ss_kobar_backup_gpg_keys
_set_alias_if_unset BACKUP_CLOUD_CREDS ss_kobar_backup_cloud_creds
_set_alias_if_unset NOTIFICATION_METHOD ss_kobar_backup_notification_method
_set_alias_if_unset GITHUB_REPO_URL ss_kobar_github_repo_url
_set_alias_if_unset GITHUB_BRANCH ss_kobar_github_branch
_set_alias_if_unset ENCRYPTION_TOOL ss_kobar_encryption_tool
_set_alias_if_unset LOCAL_BACKUP_DIR ss_kobar_backup_local_dir
_set_alias_if_unset BACKUP_LOG_FILE ss_kobar_backup_log_file
_set_alias_if_unset GITHUB_ACTION_DEPLOY_WORKFLOW ss_kobar_github_action_deploy_workflow
_set_alias_if_unset GITHUB_ACTION_BACKUP_WORKFLOW ss_kobar_github_action_backup_workflow
_set_alias_if_unset GITHUB_ACTION_MIRROR_WORKFLOW ss_kobar_github_action_mirror_workflow
_set_alias_if_unset GITHUB_ACTION_DEPLOY_BRANCH ss_kobar_github_action_deploy_branch
_set_alias_if_unset GITHUB_ACTION_BACKUP_CRON ss_kobar_github_action_backup_cron
_set_alias_if_unset GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE ss_kobar_github_action_worker_template_package
_set_alias_if_unset GITHUB_ACTION_NODE_VERSION ss_kobar_github_action_node_version
_set_alias_if_unset GITHUB_ACTION_PNPM_VERSION ss_kobar_github_action_pnpm_version
_set_alias_if_unset CLOUDFLARE_WORKER_NAME ss_kobar_cloudflare_prod_worker_name
_set_alias_if_unset CLOUDFLARE_WORKER_MAIN ss_kobar_cloudflare_prod_worker_main
_set_alias_if_unset CLOUDFLARE_WORKER_COMPATIBILITY_DATE ss_kobar_cloudflare_prod_compatibility_date
_set_alias_if_unset CLOUDFLARE_WORKER_COMPATIBILITY_FLAGS ss_kobar_cloudflare_prod_compatibility_flags
_set_alias_if_unset CLOUDFLARE_WORKER_PLACEMENT_MODE ss_kobar_cloudflare_prod_placement_mode
_set_alias_if_unset CLOUDFLARE_WORKER_ROUTE_PATTERN ss_kobar_cloudflare_prod_route_pattern
_set_alias_if_unset CLOUDFLARE_WORKER_ZONE_NAME ss_kobar_cloudflare_zone_name
_set_alias_if_unset CLOUDFLARE_WORKER_CUSTOM_DOMAIN ss_kobar_cloudflare_prod_custom_domain
_set_alias_if_unset CLOUDFLARE_WORKER_OBSERVABILITY ss_kobar_cloudflare_prod_observability
_set_alias_if_unset CLOUDFLARE_WORKER_D1_BINDING ss_kobar_cloudflare_prod_d1_binding
_set_alias_if_unset CLOUDFLARE_WORKER_D1_DATABASE_NAME ss_kobar_cloudflare_prod_d1_database_name
_set_alias_if_unset CLOUDFLARE_WORKER_D1_DATABASE_ID ss_kobar_cloudflare_prod_d1_database_id
_set_alias_if_unset CLOUDFLARE_WORKER_R2_BINDING ss_kobar_cloudflare_prod_r2_binding
_set_alias_if_unset CLOUDFLARE_WORKER_R2_BUCKET_NAME ss_kobar_cloudflare_prod_r2_bucket_name
_set_alias_if_unset CLOUDFLARE_WORKER_KV_BINDING ss_kobar_cloudflare_prod_kv_binding
_set_alias_if_unset CLOUDFLARE_WORKER_KV_NAMESPACE_ID ss_kobar_cloudflare_prod_kv_namespace_id
_set_alias_if_unset CLOUDFLARE_WORKER_IMAGE_BINDING ss_kobar_cloudflare_prod_image_binding
_set_alias_if_unset CLOUDFLARE_WORKER_LOADER_BINDING ss_kobar_cloudflare_prod_loader_binding
_set_alias_if_unset CLOUDFLARE_WORKER_SITE_URL ss_kobar_production_site_url
_set_alias_if_unset CLOUDFLARE_WORKER_STORAGE_PUBLIC_BASE_URL ss_kobar_production_storage_public_base_url

if [ -n "${GITHUB_PAT:-}" ] && [ -z "${GITHUB_TOKEN:-}" ]; then
    export GITHUB_TOKEN="$GITHUB_PAT"
fi

if [ -n "${GITLAB_PAT:-}" ] && [ -z "${GITLAB_TOKEN:-}" ]; then
    export GITLAB_TOKEN="$GITLAB_PAT"
fi

# Prefer PAT-based GitLab URLs for mirror/recovery flows, including legacy SSH configs.
if [ -n "${GITLAB_PAT:-}" ] && [ -n "${GITLAB_USERNAME:-}" ] && [ -n "${GITLAB_REPO_NAME:-}" ]; then
    if [ -z "${GITLAB_REPO_URL:-}" ] || printf '%s' "$GITLAB_REPO_URL" | grep -Eq '^(git@|ssh://git@)gitlab\.com[:/]'; then
        export GITLAB_REPO_URL="https://oauth2:${GITLAB_PAT}@gitlab.com/${GITLAB_USERNAME}/${GITLAB_REPO_NAME}.git"
    fi
fi

if [ -z "${GITLAB_REPO_URL:-}" ] && [ -n "${GITLAB_PAT:-}" ] && [ -n "${GITLAB_USERNAME:-}" ] && [ -n "${GITLAB_REPO_NAME:-}" ]; then
    export GITLAB_REPO_URL="https://oauth2:${GITLAB_PAT}@gitlab.com/${GITLAB_USERNAME}/${GITLAB_REPO_NAME}.git"
fi

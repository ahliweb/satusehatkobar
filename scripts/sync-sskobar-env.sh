#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$ROOT_DIR/.env"
DEV_VARS_FILE="$ROOT_DIR/.dev.vars"

trim() {
    local value="$1"
    value="${value#${value%%[!$' \t']*}}"
    value="${value%${value##*[!$' \t']}}"
    printf '%s' "$value"
}

load_env_file() {
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

        key="$(trim "$key")"
        value="$(trim "$value")"

        case "$key" in
            ''|*[!A-Za-z0-9_]*|[0-9]*) continue ;;
        esac

        case "$value" in
            '"'*'"') value="${value:1:-1}" ;;
            "'"*"'") value="${value:1:-1}" ;;
        esac

        printf -v "$key" '%s' "$value"
        export "$key"
    done < "$env_file"
}

require_file() {
    local path="$1"
    if [ ! -f "$path" ]; then
        printf 'Missing required file: %s\n' "$path" >&2
        exit 1
    fi
}

require_file "$ENV_FILE"
load_env_file "$ENV_FILE"

cat > "$DEV_VARS_FILE" <<EOF
# Managed by scripts/sync-sskobar-env.sh.
# Canonical source: .env (standard variable names).
# Keep real secrets in the root .env or shell environment, not in this tracked file.
AWCMS_MICRO_SITE_URL="${LOCAL_SITE_URL:-}"
AWCMS_MICRO_STORAGE_PUBLIC_BASE_URL="${LOCAL_STORAGE_PUBLIC_BASE_URL:-}"
CLOUDFLARE_ACCOUNT_ID=""
CLOUDFLARE_API_TOKEN=""
AWCMS_MICRO_D1_DATABASE_ID="${CLOUDFLARE_DEV_D1_DATABASE_ID:-}"
AWCMS_MICRO_SESSION_NAMESPACE_ID="${CLOUDFLARE_DEV_KV_NAMESPACE_ID:-}"
EOF

printf 'Updated %s from %s\n' "$DEV_VARS_FILE" "$ENV_FILE"

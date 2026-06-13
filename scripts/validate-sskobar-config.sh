#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$ROOT_DIR/.env"
ROOT_WRANGLER_FILE="$ROOT_DIR/wrangler.toml"
BACKUP_WORKFLOW_FILE="$ROOT_DIR/.github/workflows/backup-on-db-changes.yml"
BACKUP_CONFIG_EXAMPLE_FILE="$ROOT_DIR/scripts/backup/.backup-config.example"
TEMPLATE_WRANGLER_FILE="$ROOT_DIR/awcmsmicro-dev/templates/awcms-micro-default-cloudflare/wrangler.jsonc"

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

fail() {
    printf '[validate-sskobar-config] ERROR: %s\n' "$1" >&2
    exit 1
}

require_file() {
    [ -f "$1" ] || fail "Missing required file: $1"
}

require_contains() {
    local needle="$1"
    local path="$2"
    rg -F --quiet "$needle" "$path" || fail "Expected '$needle' in $path"
}

require_equal() {
    local expected="$1"
    local actual="$2"
    local label="$3"
    [ "$expected" = "$actual" ] || fail "$label mismatch: expected '$expected', got '$actual'"
}

require_file "$ENV_FILE"
require_file "$ROOT_WRANGLER_FILE"
require_file "$BACKUP_WORKFLOW_FILE"
require_file "$BACKUP_CONFIG_EXAMPLE_FILE"
require_file "$TEMPLATE_WRANGLER_FILE"

load_env_file "$ENV_FILE"

require_equal "awcms-sskkobar" "${TEMPLATE_NAME:-}" "TEMPLATE_NAME"
require_equal "awcms-sskkobar-worker" "${CLOUDFLARE_WORKER_NAME:-}" "CLOUDFLARE_WORKER_NAME"
require_equal "awcms-sskkobar-worker" "${CLOUDFLARE_DEV_WORKER_NAME:-}" "CLOUDFLARE_DEV_WORKER_NAME"
require_equal "awcms-sskkobar-d1" "${CLOUDFLARE_WORKER_D1_DATABASE_NAME:-}" "CLOUDFLARE_WORKER_D1_DATABASE_NAME"
require_equal "awcms-sskkobar-d1" "${CLOUDFLARE_DEV_D1_DATABASE_NAME:-}" "CLOUDFLARE_DEV_D1_DATABASE_NAME"
require_equal "awcms-sskkobar-d1" "${D1_DATABASE_NAME:-}" "D1_DATABASE_NAME"
require_equal "awcms-sskkobar-r2" "${CLOUDFLARE_WORKER_R2_BUCKET_NAME:-}" "CLOUDFLARE_WORKER_R2_BUCKET_NAME"
require_equal "awcms-sskkobar-r2" "${CLOUDFLARE_DEV_R2_BUCKET_NAME:-}" "CLOUDFLARE_DEV_R2_BUCKET_NAME"
require_equal "awcms-sskkobar-r2backup" "${R2_BUCKET_NAME:-}" "R2_BUCKET_NAME"

require_contains 'name = "awcms-sskkobar-worker"' "$ROOT_WRANGLER_FILE"
require_contains 'database_name = "awcms-sskkobar-d1"' "$ROOT_WRANGLER_FILE"
require_contains 'bucket_name = "awcms-sskkobar-r2"' "$ROOT_WRANGLER_FILE"

require_contains 'D1_DATABASE_NAME: awcms-sskkobar-d1' "$BACKUP_WORKFLOW_FILE"
require_contains 'R2_BUCKET_NAME: awcms-sskkobar-r2backup' "$BACKUP_WORKFLOW_FILE"

require_contains 'CLOUDFLARE_WORKER_NAME="awcms-sskkobar-worker"' "$BACKUP_CONFIG_EXAMPLE_FILE"
require_contains 'CLOUDFLARE_WORKER_D1_DATABASE_NAME="awcms-sskkobar-d1"' "$BACKUP_CONFIG_EXAMPLE_FILE"
require_contains 'CLOUDFLARE_WORKER_R2_BUCKET_NAME="awcms-sskkobar-r2"' "$BACKUP_CONFIG_EXAMPLE_FILE"
require_contains 'R2_BUCKET_NAME="awcms-sskkobar-r2backup"' "$BACKUP_CONFIG_EXAMPLE_FILE"

require_contains '"name": "awcms-sskkobar-worker"' "$TEMPLATE_WRANGLER_FILE"
require_contains '"database_name": "awcms-sskkobar-d1"' "$TEMPLATE_WRANGLER_FILE"
require_contains '"bucket_name": "awcms-sskkobar-r2"' "$TEMPLATE_WRANGLER_FILE"

printf '[validate-sskobar-config] Canonical awcms-sskkobar configuration is consistent.\n'

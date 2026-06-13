#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$ROOT_DIR/.env"
DEV_VARS_FILE="$ROOT_DIR/.dev.vars"
ROOT_ENV_EXAMPLE_FILE="$ROOT_DIR/.env.example"
ROOT_WRANGLER_FILE="$ROOT_DIR/wrangler.toml"
DEPLOY_WORKFLOW_FILE="$ROOT_DIR/.github/workflows/deploy.yml"
BACKUP_WORKFLOW_FILE="$ROOT_DIR/.github/workflows/backup-on-db-changes.yml"
BACKUP_CONFIG_EXAMPLE_FILE="$ROOT_DIR/scripts/backup/.backup-config.example"

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

TEMPLATE_DIR_RELATIVE="${CLOUDFLARE_DEV_WORKER_MAIN%/src/worker.ts}"
TEMPLATE_DIR="$ROOT_DIR/$TEMPLATE_DIR_RELATIVE"
TEMPLATE_WRANGLER_FILE="$TEMPLATE_DIR/wrangler.jsonc"
TEMPLATE_ENV_EXAMPLE_FILE="$TEMPLATE_DIR/.env.example"
TEMPLATE_PACKAGE_FILE="$TEMPLATE_DIR/package.json"
GH_OPEN='${{'
GH_CLOSE='}}'
DOLLAR='$'

require_file "$TEMPLATE_WRANGLER_FILE"
require_file "$TEMPLATE_PACKAGE_FILE"

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

cat > "$ROOT_ENV_EXAMPLE_FILE" <<EOF
# Canonical operator environment for the satusehatkobar workspace.
# Copy to .env and fill the blank secrets or IDs locally.

PROJECT_SLUG="${PROJECT_SLUG:-satusehatkobar}"
WORKSPACE_ENVIRONMENT="${WORKSPACE_ENVIRONMENT:-development}"
TEMPLATE_NAME="${TEMPLATE_NAME:-awcms-sskkobar}"

LOCAL_SITE_URL="${LOCAL_SITE_URL:-}"
LOCAL_STORAGE_PUBLIC_BASE_URL="${LOCAL_STORAGE_PUBLIC_BASE_URL:-}"
PRODUCTION_SITE_URL="${PRODUCTION_SITE_URL:-}"
PRODUCTION_STORAGE_PUBLIC_BASE_URL="${PRODUCTION_STORAGE_PUBLIC_BASE_URL:-}"

CLOUDFLARE_ACCOUNT_ID=""
CLOUDFLARE_API_TOKEN=""
CLOUDFLARE_DEPLOY_TOKEN=""
CLOUDFLARE_ZONE_NAME="${CLOUDFLARE_ZONE_NAME:-}"

CLOUDFLARE_DEV_WORKER_NAME="${CLOUDFLARE_DEV_WORKER_NAME:-}"
CLOUDFLARE_DEV_WORKER_MAIN="${CLOUDFLARE_DEV_WORKER_MAIN:-}"
CLOUDFLARE_DEV_COMPATIBILITY_DATE="${CLOUDFLARE_DEV_COMPATIBILITY_DATE:-}"
CLOUDFLARE_DEV_COMPATIBILITY_FLAGS="${CLOUDFLARE_DEV_COMPATIBILITY_FLAGS:-}"
CLOUDFLARE_DEV_PLACEMENT_MODE="${CLOUDFLARE_DEV_PLACEMENT_MODE:-}"
CLOUDFLARE_DEV_ROUTE_PATTERN="${CLOUDFLARE_DEV_ROUTE_PATTERN:-}"
CLOUDFLARE_DEV_CUSTOM_DOMAIN="${CLOUDFLARE_DEV_CUSTOM_DOMAIN:-false}"
CLOUDFLARE_DEV_OBSERVABILITY="${CLOUDFLARE_DEV_OBSERVABILITY:-true}"
CLOUDFLARE_DEV_D1_BINDING="${CLOUDFLARE_DEV_D1_BINDING:-DB}"
CLOUDFLARE_DEV_D1_DATABASE_NAME="${CLOUDFLARE_DEV_D1_DATABASE_NAME:-}"
CLOUDFLARE_DEV_D1_DATABASE_ID="REPLACE_WITH_DEVELOPMENT_D1_DATABASE_ID"
CLOUDFLARE_DEV_R2_BINDING="${CLOUDFLARE_DEV_R2_BINDING:-MEDIA}"
CLOUDFLARE_DEV_R2_BUCKET_NAME="${CLOUDFLARE_DEV_R2_BUCKET_NAME:-}"
CLOUDFLARE_DEV_KV_BINDING="${CLOUDFLARE_DEV_KV_BINDING:-SESSION}"
CLOUDFLARE_DEV_KV_NAMESPACE_ID="REPLACE_WITH_DEVELOPMENT_KV_NAMESPACE_ID"
CLOUDFLARE_DEV_IMAGE_BINDING="${CLOUDFLARE_DEV_IMAGE_BINDING:-IMAGES}"
CLOUDFLARE_DEV_LOADER_BINDING="${CLOUDFLARE_DEV_LOADER_BINDING:-LOADER}"

CLOUDFLARE_WORKER_NAME="${CLOUDFLARE_WORKER_NAME:-}"
CLOUDFLARE_WORKER_MAIN="${CLOUDFLARE_WORKER_MAIN:-./src/worker.ts}"
CLOUDFLARE_WORKER_COMPATIBILITY_DATE="${CLOUDFLARE_WORKER_COMPATIBILITY_DATE:-}"
CLOUDFLARE_WORKER_COMPATIBILITY_FLAGS="${CLOUDFLARE_WORKER_COMPATIBILITY_FLAGS:-}"
CLOUDFLARE_WORKER_PLACEMENT_MODE="${CLOUDFLARE_WORKER_PLACEMENT_MODE:-}"
CLOUDFLARE_WORKER_ROUTE_PATTERN="${CLOUDFLARE_WORKER_ROUTE_PATTERN:-}"
CLOUDFLARE_WORKER_CUSTOM_DOMAIN="${CLOUDFLARE_WORKER_CUSTOM_DOMAIN:-false}"
CLOUDFLARE_WORKER_OBSERVABILITY="${CLOUDFLARE_WORKER_OBSERVABILITY:-true}"
CLOUDFLARE_WORKER_D1_BINDING="${CLOUDFLARE_WORKER_D1_BINDING:-DB}"
CLOUDFLARE_WORKER_D1_DATABASE_NAME="${CLOUDFLARE_WORKER_D1_DATABASE_NAME:-}"
CLOUDFLARE_WORKER_D1_DATABASE_ID="REPLACE_WITH_PRODUCTION_D1_DATABASE_ID"
CLOUDFLARE_WORKER_R2_BINDING="${CLOUDFLARE_WORKER_R2_BINDING:-MEDIA}"
CLOUDFLARE_WORKER_R2_BUCKET_NAME="${CLOUDFLARE_WORKER_R2_BUCKET_NAME:-}"
CLOUDFLARE_WORKER_KV_BINDING="${CLOUDFLARE_WORKER_KV_BINDING:-SESSION}"
CLOUDFLARE_WORKER_KV_NAMESPACE_ID="REPLACE_WITH_PRODUCTION_KV_NAMESPACE_ID"
CLOUDFLARE_WORKER_IMAGE_BINDING="${CLOUDFLARE_WORKER_IMAGE_BINDING:-IMAGES}"
CLOUDFLARE_WORKER_LOADER_BINDING="${CLOUDFLARE_WORKER_LOADER_BINDING:-LOADER}"
CLOUDFLARE_WORKER_SITE_URL="${CLOUDFLARE_WORKER_SITE_URL:-}"
CLOUDFLARE_WORKER_STORAGE_PUBLIC_BASE_URL="${CLOUDFLARE_WORKER_STORAGE_PUBLIC_BASE_URL:-}"

R2_BUCKET_NAME="${R2_BUCKET_NAME:-}"
R2_REGION="${R2_REGION:-auto}"
D1_DATABASE_NAME="${D1_DATABASE_NAME:-}"
D1_BACKUP_KEEP_COUNT="${D1_BACKUP_KEEP_COUNT:-7}"
BACKUP_CRON_SCHEDULE="${BACKUP_CRON_SCHEDULE:-0 2 * * *}"
BACKUP_CONTENT="${BACKUP_CONTENT:-all}"
BACKUP_PASSPHRASE=""
BACKUP_SSH_KEYS="${BACKUP_SSH_KEYS:-true}"
BACKUP_GPG_KEYS="${BACKUP_GPG_KEYS:-false}"
BACKUP_CLOUD_CREDS="${BACKUP_CLOUD_CREDS:-true}"
NOTIFICATION_METHOD="${NOTIFICATION_METHOD:-none}"
LOCAL_BACKUP_DIR="${LOCAL_BACKUP_DIR:-/tmp/awcms-backups}"
BACKUP_LOG_FILE="${BACKUP_LOG_FILE:-\$HOME/.awcms-backup.log}"
ENCRYPTION_TOOL="${ENCRYPTION_TOOL:-age}"

GITHUB_REPO_URL="${GITHUB_REPO_URL:-}"
GITHUB_BRANCH="${GITHUB_BRANCH:-main}"
GITHUB_PAT=""
GITHUB_ACTION_DEPLOY_WORKFLOW="${GITHUB_ACTION_DEPLOY_WORKFLOW:-deploy.yml}"
GITHUB_ACTION_BACKUP_WORKFLOW="${GITHUB_ACTION_BACKUP_WORKFLOW:-backup-automated.yml}"
GITHUB_ACTION_MIRROR_WORKFLOW="${GITHUB_ACTION_MIRROR_WORKFLOW:-mirror-to-gitlab.yml}"
GITHUB_ACTION_DEPLOY_BRANCH="${GITHUB_ACTION_DEPLOY_BRANCH:-main}"
GITHUB_ACTION_BACKUP_CRON="${GITHUB_ACTION_BACKUP_CRON:-0 2 * * *}"
GITHUB_ACTION_TEMPLATE_NAME="${GITHUB_ACTION_TEMPLATE_NAME:-}"
GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE="${GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE:-}"
GITHUB_ACTION_NODE_VERSION="${GITHUB_ACTION_NODE_VERSION:-22}"
GITHUB_ACTION_PNPM_VERSION="${GITHUB_ACTION_PNPM_VERSION:-11.1.3}"

GITLAB_USERNAME=""
GITLAB_REPO_NAME="${GITLAB_REPO_NAME:-}"
GITLAB_VISIBILITY="${GITLAB_VISIBILITY:-private}"
GITLAB_PAT=""
GITLAB_SSH_KEY_PATH="${GITLAB_SSH_KEY_PATH:-\$HOME/.ssh/gitlab_mirror}"
EOF

cat > "$ROOT_WRANGLER_FILE" <<EOF
name = "${CLOUDFLARE_DEV_WORKER_NAME:-}"
main = "${CLOUDFLARE_DEV_WORKER_MAIN:-}"
compatibility_date = "${CLOUDFLARE_DEV_COMPATIBILITY_DATE:-}"
compatibility_flags = ["${CLOUDFLARE_DEV_COMPATIBILITY_FLAGS:-nodejs_compat}"]

[placement]
mode = "${CLOUDFLARE_DEV_PLACEMENT_MODE:-smart}"

# Development D1 database
[[d1_databases]]
binding = "${CLOUDFLARE_DEV_D1_BINDING:-DB}"
database_name = "${CLOUDFLARE_DEV_D1_DATABASE_NAME:-}"
database_id = "${CLOUDFLARE_DEV_D1_DATABASE_ID:-}"
migrations_dir = "awcmsmicro-dev/packages/core/src/database/migrations"

# Development R2 bucket for media storage
[[r2_buckets]]
binding = "${CLOUDFLARE_DEV_R2_BINDING:-MEDIA}"
bucket_name = "${CLOUDFLARE_DEV_R2_BUCKET_NAME:-}"

# Development KV namespace for sessions
[[kv_namespaces]]
binding = "${CLOUDFLARE_DEV_KV_BINDING:-SESSION}"
id = "${CLOUDFLARE_DEV_KV_NAMESPACE_ID:-}"

# Cloudflare Images binding
[images]
binding = "${CLOUDFLARE_DEV_IMAGE_BINDING:-IMAGES}"

# Worker loaders
[[worker_loaders]]
binding = "${CLOUDFLARE_DEV_LOADER_BINDING:-LOADER}"

# Environment variables
[vars]
AWCMS_MICRO_SITE_URL = "${LOCAL_SITE_URL:-}"
AWCMS_MICRO_STORAGE_PUBLIC_BASE_URL = "${LOCAL_STORAGE_PUBLIC_BASE_URL:-}"
AWCMS_MICRO_GALLERY_MEDIA_STORAGE = "r2"
AWCMS_MICRO_GALLERY_CLOUDFLARE_IMAGES = "optional"
AWCMS_MICRO_GALLERY_CLOUDFLARE_STREAM = "optional"

# Observability
[observability]
enabled = ${CLOUDFLARE_DEV_OBSERVABILITY:-true}

# Development settings
[dev]
port = 8787
local_protocol = "http"
EOF

cat > "$DEPLOY_WORKFLOW_FILE" <<EOF
name: Deploy to Cloudflare Workers

on:
  push:
    branches:
      - main

jobs:
  deploy:
    name: Build and Deploy
    runs-on: ubuntu-latest
    permissions:
      contents: read
    env:
      NODE_VERSION: ${GH_OPEN} vars.GITHUB_ACTION_NODE_VERSION || '${GITHUB_ACTION_NODE_VERSION:-22}' ${GH_CLOSE}
      PNPM_VERSION: ${GH_OPEN} vars.GITHUB_ACTION_PNPM_VERSION || '${GITHUB_ACTION_PNPM_VERSION:-11.1.3}' ${GH_CLOSE}
      TEMPLATE_NAME: ${GH_OPEN} vars.GITHUB_ACTION_TEMPLATE_NAME || '${GITHUB_ACTION_TEMPLATE_NAME:-awcms-sskkobar}' ${GH_CLOSE}
      WORKER_PACKAGE: ${GH_OPEN} vars.GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE || '${GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE:-@awcms-sskobar/template-sskobar-cloudflare}' ${GH_CLOSE}

    steps:
      - name: Checkout repository
        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
        with:
          persist-credentials: false

      - name: Install pnpm
        uses: pnpm/action-setup@0e279bb959325dab635dd2c09392533439d90093 # v6.0.8
        with:
          version: ${GH_OPEN} env.PNPM_VERSION ${GH_CLOSE}

      - name: Setup Node.js
        uses: actions/setup-node@48b55a011bda9f5d6aeb4c2d9c7362e8dae4041e # v6.4.0
        with:
          node-version: ${GH_OPEN} env.NODE_VERSION ${GH_CLOSE}
          cache: pnpm
          cache-dependency-path: awcmsmicro-dev/pnpm-lock.yaml

      - name: Install dependencies
        run: pnpm install --frozen-lockfile
        working-directory: awcmsmicro-dev

      - name: Validate Canonical Template Configuration
        run: |
          echo "Canonical template: \$TEMPLATE_NAME"
          echo "Worker package: \$WORKER_PACKAGE"
          bash scripts/validate-sskobar-config.sh

      - name: Build packages
        run: pnpm build
        working-directory: awcmsmicro-dev

      - name: Build Cloudflare Template
        run: pnpm --filter "${DOLLAR}WORKER_PACKAGE" build
        working-directory: awcmsmicro-dev

      - name: Deploy to Cloudflare Workers
        run: pnpm --filter "${DOLLAR}WORKER_PACKAGE" exec wrangler deploy
        working-directory: awcmsmicro-dev
        env:
          CLOUDFLARE_API_TOKEN: ${GH_OPEN} secrets.CLOUDFLARE_DEPLOY_TOKEN || secrets.CLOUDFLARE_API_TOKEN ${GH_CLOSE}
          CLOUDFLARE_ACCOUNT_ID: ${GH_OPEN} secrets.CLOUDFLARE_ACCOUNT_ID ${GH_CLOSE}
EOF

cat > "$BACKUP_WORKFLOW_FILE" <<EOF
name: Backup on Database Changes

on:
  push:
    branches:
      - main
    paths:
      - 'awcmsmicro-dev/packages/core/src/database/migrations/**'
      - 'awcmsmicro-dev/packages/core/src/schema/**'
      - '.github/workflows/backup-on-db-changes.yml'
  workflow_dispatch:
    inputs:
      backup_type:
        description: 'Type of backup to run'
        required: true
        default: 'database'
        type: choice
        options:
          - database
          - full

permissions:
  contents: read

env:
  NODE_VERSION: '${GITHUB_ACTION_NODE_VERSION:-22}'
  PNPM_VERSION: '${GITHUB_ACTION_PNPM_VERSION:-11.1.3}'

jobs:
  backup-database:
    name: Backup D1 Database
    runs-on: ubuntu-latest
    env:
      CLOUDFLARE_API_TOKEN: ${GH_OPEN} secrets.CLOUDFLARE_API_TOKEN ${GH_CLOSE}
      CLOUDFLARE_ACCOUNT_ID: ${GH_OPEN} secrets.CLOUDFLARE_ACCOUNT_ID ${GH_CLOSE}
      D1_DATABASE_NAME: ${D1_DATABASE_NAME:-}
      R2_BUCKET_NAME: ${R2_BUCKET_NAME:-}
      BACKUP_PASSPHRASE: ${GH_OPEN} secrets.BACKUP_PASSPHRASE ${GH_CLOSE}

    steps:
      - name: Checkout repository
        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
        with:
          persist-credentials: false

      - name: Install wrangler
        run: npm install -g wrangler

      - name: Export D1 database
        run: |
          TABLES=${DOLLAR}(wrangler d1 execute "${DOLLAR}D1_DATABASE_NAME" --remote --command "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE '_emdash_fts_%' ORDER BY name;" 2>/dev/null | jq -r '.[0].results[].name' | tr '\n' ' ')
          echo "Exporting tables: ${DOLLAR}TABLES"
          TABLE_ARGS=""
          for TABLE in ${DOLLAR}TABLES; do
            TABLE_ARGS="${DOLLAR}TABLE_ARGS --table ${DOLLAR}TABLE"
          done
          wrangler d1 export "${DOLLAR}D1_DATABASE_NAME" --remote --output /tmp/backup.sql ${DOLLAR}TABLE_ARGS -y

      - name: Encrypt backup
        run: |
          TIMESTAMP=${DOLLAR}(date +%Y%m%d-%H%M%S)
          openssl enc -aes-256-cbc -salt -pbkdf2 \\
            -in /tmp/backup.sql \\
            -out "/tmp/backup-${DOLLAR}{TIMESTAMP}.sql.enc" \\
            -pass pass:"${DOLLAR}BACKUP_PASSPHRASE"
          echo "TIMESTAMP=${DOLLAR}{TIMESTAMP}" >> ${DOLLAR}GITHUB_ENV

      - name: Upload to R2
        run: |
          wrangler r2 object put "${DOLLAR}R2_BUCKET_NAME/backups/db/backup-${DOLLAR}{TIMESTAMP}.sql.enc" \\
            --file "/tmp/backup-${DOLLAR}{TIMESTAMP}.sql.enc" \\
            --remote -y

      - name: Cleanup old backups (keep last ${D1_BACKUP_KEEP_COUNT:-7})
        run: |
          BACKUPS=${DOLLAR}(wrangler r2 object list "${DOLLAR}R2_BUCKET_NAME" --prefix "backups/db/" --remote --format json 2>/dev/null | jq -r '.objects[].key' | sort)
          BACKUP_COUNT=${DOLLAR}(echo "${DOLLAR}BACKUPS" | wc -l)
          if [ "${DOLLAR}BACKUP_COUNT" -gt ${D1_BACKUP_KEEP_COUNT:-7} ]; then
            OLD_BACKUPS=${DOLLAR}(echo "${DOLLAR}BACKUPS" | head -n -${D1_BACKUP_KEEP_COUNT:-7})
            echo "Removing old backups:"
            echo "${DOLLAR}OLD_BACKUPS"
            while read -r KEY; do
              wrangler r2 object delete "${DOLLAR}R2_BUCKET_NAME/${DOLLAR}KEY" --remote -y
            done <<< "${DOLLAR}OLD_BACKUPS"
          else
            echo "Keeping all ${DOLLAR}BACKUP_COUNT backups (under limit)"
          fi

      - name: Secure cleanup
        if: always()
        run: |
          shred -u /tmp/backup.sql 2>/dev/null || rm -f /tmp/backup.sql
          rm -f /tmp/backup-*.sql.enc

  notify:
    name: Notify Result
    runs-on: ubuntu-latest
    needs: [backup-database]
    if: always()

    steps:
      - name: Check backup status
        run: |
          if [ "${GH_OPEN} needs.backup-database.result ${GH_CLOSE}" = "success" ]; then
            echo "✅ Database backup completed successfully"
          else
            echo "❌ Database backup failed - check logs"
            exit 1
          fi
EOF

cat > "$BACKUP_CONFIG_EXAMPLE_FILE" <<EOF
# =============================================================================
# AWCMS-Micro Backup Configuration
# =============================================================================
# This file contains ALL backup and recovery settings in one place.
#
# SECURITY: This file MUST be encrypted before committing to any repository.
# Use: bash scripts/backup/encrypt-config.sh
# Decrypt: bash scripts/backup/decrypt-config.sh
#
# The encrypted file (.backup-config.age) is safe to store in private repos
# or cloud storage. NEVER commit this unencrypted file.
# =============================================================================

# ---------------------------------------------------------------------------
# GitLab Backup Repository (Private)
# ---------------------------------------------------------------------------
GITLAB_USERNAME="your-gitlab-username"
GITLAB_REPO_NAME="${GITLAB_REPO_NAME:-awcms-sskobar}"
GITLAB_VISIBILITY="${GITLAB_VISIBILITY:-private}"
GITLAB_PAT="your-gitlab-pat-here"
GITLAB_REPO_URL="https://oauth2:\${GITLAB_PAT}@gitlab.com/\${GITLAB_USERNAME}/\${GITLAB_REPO_NAME}.git"
GITLAB_SSH_KEY_PATH="${GITLAB_SSH_KEY_PATH:-\$HOME/.ssh/gitlab_mirror}"

# ---------------------------------------------------------------------------
# GitHub Repository
# ---------------------------------------------------------------------------
GITHUB_REPO_URL="${GITHUB_REPO_URL:-git@github.com:ahliweb/satusehatkobar.git}"
GITHUB_BRANCH="${GITHUB_BRANCH:-main}"
GITHUB_PAT="your-github-pat-here"

# ---------------------------------------------------------------------------
# GitHub Actions (Workflows)
# ---------------------------------------------------------------------------
GITHUB_ACTION_DEPLOY_WORKFLOW="${GITHUB_ACTION_DEPLOY_WORKFLOW:-deploy.yml}"
GITHUB_ACTION_BACKUP_WORKFLOW="${GITHUB_ACTION_BACKUP_WORKFLOW:-backup-automated.yml}"
GITHUB_ACTION_MIRROR_WORKFLOW="${GITHUB_ACTION_MIRROR_WORKFLOW:-mirror-to-gitlab.yml}"
GITHUB_ACTION_DEPLOY_BRANCH="${GITHUB_ACTION_DEPLOY_BRANCH:-main}"
GITHUB_ACTION_BACKUP_CRON="${GITHUB_ACTION_BACKUP_CRON:-0 2 * * *}"
GITHUB_ACTION_TEMPLATE_NAME="${GITHUB_ACTION_TEMPLATE_NAME:-awcms-sskkobar}"
GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE="${GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE:-@awcms-sskobar/template-sskobar-cloudflare}"
GITHUB_ACTION_NODE_VERSION="${GITHUB_ACTION_NODE_VERSION:-22}"
GITHUB_ACTION_PNPM_VERSION="${GITHUB_ACTION_PNPM_VERSION:-11.1.3}"

# ---------------------------------------------------------------------------
# Cloudflare R2 (Backup Storage)
# ---------------------------------------------------------------------------
R2_BUCKET_NAME="${R2_BUCKET_NAME:-}"
R2_REGION="${R2_REGION:-auto}"

# ---------------------------------------------------------------------------
# Cloudflare Deployment (Worker: ${CLOUDFLARE_WORKER_NAME:-})
# ---------------------------------------------------------------------------
CLOUDFLARE_WORKER_NAME="${CLOUDFLARE_WORKER_NAME:-}"
CLOUDFLARE_WORKER_MAIN="${CLOUDFLARE_WORKER_MAIN:-./src/worker.ts}"
CLOUDFLARE_WORKER_COMPATIBILITY_DATE="${CLOUDFLARE_WORKER_COMPATIBILITY_DATE:-}"
CLOUDFLARE_WORKER_COMPATIBILITY_FLAGS=("${CLOUDFLARE_WORKER_COMPATIBILITY_FLAGS:-nodejs_compat}")
CLOUDFLARE_WORKER_PLACEMENT_MODE="${CLOUDFLARE_WORKER_PLACEMENT_MODE:-smart}"
CLOUDFLARE_WORKER_ROUTE_PATTERN="${CLOUDFLARE_WORKER_ROUTE_PATTERN:-}"
CLOUDFLARE_WORKER_ZONE_NAME="${CLOUDFLARE_ZONE_NAME:-}"
CLOUDFLARE_WORKER_CUSTOM_DOMAIN=${CLOUDFLARE_WORKER_CUSTOM_DOMAIN:-false}
CLOUDFLARE_WORKER_OBSERVABILITY=${CLOUDFLARE_WORKER_OBSERVABILITY:-true}

CLOUDFLARE_WORKER_D1_BINDING="${CLOUDFLARE_WORKER_D1_BINDING:-DB}"
CLOUDFLARE_WORKER_D1_DATABASE_NAME="${CLOUDFLARE_WORKER_D1_DATABASE_NAME:-}"
CLOUDFLARE_WORKER_D1_DATABASE_ID="${CLOUDFLARE_WORKER_D1_DATABASE_ID:-REPLACE_WITH_PRODUCTION_D1_DATABASE_ID}"

CLOUDFLARE_WORKER_R2_BINDING="${CLOUDFLARE_WORKER_R2_BINDING:-MEDIA}"
CLOUDFLARE_WORKER_R2_BUCKET_NAME="${CLOUDFLARE_WORKER_R2_BUCKET_NAME:-}"

CLOUDFLARE_WORKER_KV_BINDING="${CLOUDFLARE_WORKER_KV_BINDING:-SESSION}"
CLOUDFLARE_WORKER_KV_NAMESPACE_ID="${CLOUDFLARE_WORKER_KV_NAMESPACE_ID:-REPLACE_WITH_PRODUCTION_KV_NAMESPACE_ID}"

CLOUDFLARE_WORKER_IMAGE_BINDING="${CLOUDFLARE_WORKER_IMAGE_BINDING:-IMAGES}"
CLOUDFLARE_WORKER_LOADER_BINDING="${CLOUDFLARE_WORKER_LOADER_BINDING:-LOADER}"

CLOUDFLARE_WORKER_SITE_URL="${CLOUDFLARE_WORKER_SITE_URL:-}"
CLOUDFLARE_WORKER_STORAGE_PUBLIC_BASE_URL="${CLOUDFLARE_WORKER_STORAGE_PUBLIC_BASE_URL:-}"

CLOUDFLARE_API_TOKEN="your-cloudflare-api-token"
CLOUDFLARE_ACCOUNT_ID="your-cloudflare-account-id"

# ---------------------------------------------------------------------------
# Cloudflare D1 (Database)
# ---------------------------------------------------------------------------
D1_DATABASE_NAME="${D1_DATABASE_NAME:-}"
D1_BACKUP_KEEP_COUNT=${D1_BACKUP_KEEP_COUNT:-7}

# ---------------------------------------------------------------------------
# Encryption Settings
# ---------------------------------------------------------------------------
BACKUP_PASSPHRASE="your-secure-master-passphrase-min-8-chars"
ENCRYPTION_TOOL="${ENCRYPTION_TOOL:-age}"

# ---------------------------------------------------------------------------
# Backup Schedule
# ---------------------------------------------------------------------------
BACKUP_CRON_SCHEDULE="${BACKUP_CRON_SCHEDULE:-0 2 * * *}"
BACKUP_CONTENT="${BACKUP_CONTENT:-all}"

# ---------------------------------------------------------------------------
# Dotfiles to Backup
# ---------------------------------------------------------------------------
EXTRA_DOTFILES=(
    # ".config/kitty/kitty.conf"
    # ".config/wezterm/wezterm.lua"
    # ".local/share/nvim/lazy-lock.json"
)

BACKUP_SSH_KEYS=${BACKUP_SSH_KEYS:-true}
BACKUP_GPG_KEYS=${BACKUP_GPG_KEYS:-false}
BACKUP_CLOUD_CREDS=${BACKUP_CLOUD_CREDS:-true}

# ---------------------------------------------------------------------------
# Notification Settings
# ---------------------------------------------------------------------------
NOTIFICATION_METHOD="${NOTIFICATION_METHOD:-none}"
DISCORD_WEBHOOK_URL=""

# ---------------------------------------------------------------------------
# Local Paths
# ---------------------------------------------------------------------------
LOCAL_BACKUP_DIR="${LOCAL_BACKUP_DIR:-/tmp/awcms-backups}"
BACKUP_LOG_FILE="${BACKUP_LOG_FILE:-\$HOME/.awcms-backup.log}"
EOF

cat > "$TEMPLATE_WRANGLER_FILE" <<EOF
{
	"${DOLLAR}schema": "node_modules/wrangler/config-schema.json",
	"name": "${CLOUDFLARE_WORKER_NAME:-}",
	"main": "${CLOUDFLARE_WORKER_MAIN:-./src/worker.ts}",
	"compatibility_date": "${CLOUDFLARE_WORKER_COMPATIBILITY_DATE:-}",
	"compatibility_flags": ["${CLOUDFLARE_WORKER_COMPATIBILITY_FLAGS:-nodejs_compat}"],
	"placement": { "mode": "${CLOUDFLARE_WORKER_PLACEMENT_MODE:-smart}" },
	"routes": [
		{
			"pattern": "${CLOUDFLARE_WORKER_ROUTE_PATTERN:-}",
			"zone_name": "${CLOUDFLARE_ZONE_NAME:-}",
			"custom_domain": ${CLOUDFLARE_WORKER_CUSTOM_DOMAIN:-false}
		}
	],
	"d1_databases": [
		{
			"binding": "${CLOUDFLARE_WORKER_D1_BINDING:-DB}",
			"database_name": "${CLOUDFLARE_WORKER_D1_DATABASE_NAME:-}",
			"database_id": "${CLOUDFLARE_WORKER_D1_DATABASE_ID:-}"
		}
	],
	"r2_buckets": [
		{
			"binding": "${CLOUDFLARE_WORKER_R2_BINDING:-MEDIA}",
			"bucket_name": "${CLOUDFLARE_WORKER_R2_BUCKET_NAME:-}"
		}
	],
	"kv_namespaces": [
		{
			"binding": "${CLOUDFLARE_WORKER_KV_BINDING:-SESSION}",
			"id": "${CLOUDFLARE_WORKER_KV_NAMESPACE_ID:-}"
		}
	],
	"images": {
		"binding": "${CLOUDFLARE_WORKER_IMAGE_BINDING:-IMAGES}"
	},
	"worker_loaders": [
		{
			"binding": "${CLOUDFLARE_WORKER_LOADER_BINDING:-LOADER}"
		}
	],
	"vars": {
		"AWCMS_MICRO_SITE_URL": "${PRODUCTION_SITE_URL:-}",
		"AWCMS_MICRO_STORAGE_PUBLIC_BASE_URL": "${PRODUCTION_STORAGE_PUBLIC_BASE_URL:-}",
		"AWCMS_MICRO_GALLERY_MEDIA_STORAGE": "r2",
		"AWCMS_MICRO_GALLERY_CLOUDFLARE_IMAGES": "optional",
		"AWCMS_MICRO_GALLERY_CLOUDFLARE_STREAM": "optional"
	},
	"observability": {
		"enabled": ${CLOUDFLARE_WORKER_OBSERVABILITY:-true}
	}
}
EOF

cat > "$TEMPLATE_ENV_EXAMPLE_FILE" <<EOF
# Optional shell-based local environment file. Do not commit real secrets.
# Canonical deployment template identifier: ${TEMPLATE_NAME:-awcms-sskkobar}
AWCMS_MICRO_SITE_URL="${PRODUCTION_SITE_URL:-}"
AWCMS_MICRO_STORAGE_PUBLIC_BASE_URL="${PRODUCTION_STORAGE_PUBLIC_BASE_URL:-}"
CLOUDFLARE_ACCOUNT_ID=""
CLOUDFLARE_API_TOKEN=""
AWCMS_MICRO_D1_DATABASE_ID="REPLACE_WITH_AWCMS_MICRO_D1_DATABASE_ID"
AWCMS_MICRO_SESSION_NAMESPACE_ID="REPLACE_WITH_AWCMS_MICRO_SESSION_NAMESPACE_ID"
EOF

cat > "$TEMPLATE_PACKAGE_FILE" <<EOF
{
	"name": "${GITHUB_ACTION_WORKER_TEMPLATE_PACKAGE:-@awcms-sskobar/template-sskobar-cloudflare}",
	"version": "0.1.0",
	"private": true,
	"type": "module",
	"license": "SEE LICENSE IN LICENSE.md",
	"emdash": {
		"seed": "seed/seed.json"
	},
	"scripts": {
		"dev": "astro dev",
		"build": "astro build",
		"preview": "astro preview",
		"deploy": "astro build && wrangler deploy",
		"validate:cloudflare-env": "bash ./scripts/validate-cloudflare-env.sh",
		"typecheck": "astro check",
		"test": "pnpm typecheck"
	},
	"dependencies": {
		"@astrojs/cloudflare": "catalog:",
		"@astrojs/react": "catalog:",
		"@awcms-micro/plugin-sikesra": "workspace:*",
		"@awcms-micro/plugin-gallery": "workspace:*",
		"@emdash-cms/cloudflare": "workspace:*",
		"astro": "catalog:",
		"emdash": "workspace:*",
		"react": "catalog:",
		"react-dom": "catalog:"
	},
	"devDependencies": {
		"@astrojs/check": "catalog:",
		"@cloudflare/workers-types": "catalog:",
		"wrangler": "catalog:"
	}
}
EOF

printf 'Updated %s from %s\n' "$DEV_VARS_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$ROOT_ENV_EXAMPLE_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$ROOT_WRANGLER_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$DEPLOY_WORKFLOW_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$BACKUP_WORKFLOW_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$BACKUP_CONFIG_EXAMPLE_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$TEMPLATE_WRANGLER_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$TEMPLATE_ENV_EXAMPLE_FILE" "$ENV_FILE"
printf 'Updated %s from %s\n' "$TEMPLATE_PACKAGE_FILE" "$ENV_FILE"

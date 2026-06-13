#!/bin/bash

set -euo pipefail

# Syncs awcms-latest/ with the root-level governance files and unique configs from
# ahliweb/awcms-micro. Large subdirectories that already exist in the repo root
# (awcmsmicro-dev/, emdash-latest/, docs/, scripts/) are excluded to prevent
# redundant duplication and excessive repository size growth.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TARGET_DIR="$ROOT_DIR/awcms-latest"
REPO_URL="https://github.com/ahliweb/awcms-micro.git"
REPO_BRANCH="main"
METADATA_FILE="$ROOT_DIR/docs/upstream-sync/LAST_AWCMS_MICRO_FETCH.md"
TEMP_DIR="$(mktemp -d)"
SOURCE_DIR="$TEMP_DIR/awcms-micro"

cleanup() {
	rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

echo "Cloning latest AWCMS-Micro..."
git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$SOURCE_DIR"
UPSTREAM_SHA="$(git -C "$SOURCE_DIR" rev-parse HEAD)"
FETCHED_AT="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

mkdir -p "$TARGET_DIR"
rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"
mkdir -p "$(dirname "$METADATA_FILE")"

rsync -a \
	--delete \
	--exclude='.git' \
	--exclude='node_modules' \
	--exclude='dist' \
	--exclude='.astro' \
	--exclude='.wrangler' \
	--exclude='awcmsmicro-dev' \
	--exclude='emdash-latest' \
	--exclude='docs' \
	--exclude='scripts' \
	--exclude='*.tar.gz' \
	--exclude='*.tar.xz' \
	--exclude='*.tar.bz2' \
	--exclude='*.zip' \
	"$SOURCE_DIR/" "$TARGET_DIR/"

cat >"$METADATA_FILE" <<EOF
# Last AWCMS-Micro Fetch

## Source

- Upstream repository URL: $REPO_URL
- Upstream branch: $REPO_BRANCH
- Upstream commit SHA: $UPSTREAM_SHA
- Fetch date: $FETCHED_AT
- Target folder: awcms-latest/

## Excluded Paths

The following are excluded from awcms-latest/ because equivalent content already exists in the repo root:

- awcmsmicro-dev/ (root awcmsmicro-dev/ is authoritative)
- emdash-latest/ (root emdash-latest/ is authoritative)
- docs/ (root docs/ is authoritative)
- scripts/ (root scripts/ is authoritative)
- Binary archives (*.tar.gz, *.tar.xz, *.tar.bz2, *.zip)

## Notes

This file records the exact upstream AWCMS-Micro revision copied into awcms-latest/.
awcms-latest/ contains only root-level governance files and unique upstream configs.
EOF

echo "awcms-latest has been refreshed from upstream AWCMS-Micro ($REPO_BRANCH) at $UPSTREAM_SHA."
echo "Excluded: awcmsmicro-dev/, emdash-latest/, docs/, scripts/, binary archives."

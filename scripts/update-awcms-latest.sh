#!/bin/bash

set -euo pipefail

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
	"$SOURCE_DIR/" "$TARGET_DIR/"

cat >"$METADATA_FILE" <<EOF
# Last AWCMS-Micro Fetch

## Source

- Upstream repository URL: $REPO_URL
- Upstream branch: $REPO_BRANCH
- Upstream commit SHA: $UPSTREAM_SHA
- Fetch date: $FETCHED_AT
- Target folder: awcms-latest/

## Notes

This file records the exact upstream AWCMS-Micro revision copied into awcms-latest/.
EOF

echo "awcms-latest has been refreshed from upstream AWCMS-Micro ($REPO_BRANCH) at $UPSTREAM_SHA."

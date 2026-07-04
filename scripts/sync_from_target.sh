#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ORBIT_REPO="${ORBIT_REPO:-"$(cd "$REPO_DIR/.." && pwd)/Orbit"}"
SOURCE_DIR="$ORBIT_REPO/skills/liuyao-charting"
DEST_DIR="$REPO_DIR/liuyao-charting"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source skill not found: $SOURCE_DIR" >&2
  echo "Set ORBIT_REPO=/path/to/Orbit if the default sibling checkout is wrong." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

cp -R "$SOURCE_DIR" "$tmp_dir/liuyao-charting"
rm -rf "$DEST_DIR"
cp -R "$tmp_dir/liuyao-charting" "$DEST_DIR"

echo "Synced from: $SOURCE_DIR"
echo "Synced to:   $DEST_DIR"


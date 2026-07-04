#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ORBIT_AGENT_REPO="${ORBIT_AGENT_REPO:-"$(cd "$REPO_DIR/.." && pwd)/OrbitAgent"}"
if [[ ! -d "$ORBIT_AGENT_REPO" && -d "$(cd "$REPO_DIR/.." && pwd)/Orbit/OrbitAgent" ]]; then
  ORBIT_AGENT_REPO="$(cd "$REPO_DIR/.." && pwd)/Orbit/OrbitAgent"
fi
SOURCE_DIR="$REPO_DIR/liuyao-charting"
DEST_DIR="$ORBIT_AGENT_REPO/skills/liuyao-charting"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source skill not found: $SOURCE_DIR" >&2
  exit 1
fi
if [[ ! -d "$ORBIT_AGENT_REPO" ]]; then
  echo "OrbitAgent checkout not found: $ORBIT_AGENT_REPO" >&2
  echo "Set ORBIT_AGENT_REPO=/path/to/OrbitAgent if the default checkout is wrong." >&2
  exit 1
fi

mkdir -p "$(dirname "$DEST_DIR")"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

cp -R "$SOURCE_DIR" "$tmp_dir/liuyao-charting"
rm -rf "$DEST_DIR"
cp -R "$tmp_dir/liuyao-charting" "$DEST_DIR"

echo "Synced from: $SOURCE_DIR"
echo "Synced to:   $DEST_DIR"

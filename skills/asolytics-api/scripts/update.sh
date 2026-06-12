#!/usr/bin/env bash
#
# Update this installed asolytics-api skill to the latest version on GitHub.
# Safe to run from anywhere — it operates on the skill folder this script lives in.
#
#   bash scripts/update.sh
#
# What it does:
#   1. Clones the latest skill from GitHub into a temp dir.
#   2. Verifies the download looks like a real skill (SKILL.md + VERSION present).
#   3. Backs up the current install to a timestamped *.bak-<ts> folder (keeps the last 3).
#   4. Syncs the new files in place with `rsync --delete` so files removed upstream
#      are also removed locally (falls back to an overlay copy if rsync is missing).
#
set -euo pipefail

REPO="https://github.com/Asolytics-Pro/asolytics-app-store-optimization-api.git"
SUBDIR="skills/asolytics-api"
KEEP_BACKUPS=3

# The installed skill folder = parent of this script's directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

OLD_VERSION="$(cat "$SKILL_DIR/VERSION" 2>/dev/null || echo "unknown")"

command -v git >/dev/null 2>&1 || { echo "error: git is required to update." >&2; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Fetching latest asolytics-api skill from GitHub..."
if ! git clone --quiet --depth 1 "$REPO" "$TMP/repo"; then
  echo "error: could not clone $REPO (offline, or the repo URL changed). Nothing was changed." >&2
  exit 1
fi

SRC="$TMP/repo/$SUBDIR"

# Verify the download before touching the installed copy.
if [ ! -f "$SRC/SKILL.md" ] || [ ! -f "$SRC/VERSION" ]; then
  echo "error: the downloaded copy is missing SKILL.md or VERSION — refusing to overwrite your install." >&2
  exit 1
fi

NEW_VERSION="$(cat "$SRC/VERSION")"

# Timestamped backup (so repeated updates don't clobber the previous backup).
TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="${SKILL_DIR}.bak-${TS}"
cp -R "$SKILL_DIR" "$BACKUP"

# Keep only the most recent $KEEP_BACKUPS backups.
ls -dt "${SKILL_DIR}".bak-* 2>/dev/null | tail -n +$((KEEP_BACKUPS + 1)) | while read -r old; do
  rm -rf "$old"
done

# Sync new files. Prefer rsync --delete (true sync); fall back to overlay copy.
if command -v rsync >/dev/null 2>&1; then
  rsync -a --delete "$SRC/" "$SKILL_DIR/"
else
  echo "note: rsync not found — overlaying files (upstream-deleted files may linger)." >&2
  cp -R "$SRC/." "$SKILL_DIR/"
fi

echo "Updated asolytics-api: $OLD_VERSION -> $NEW_VERSION"
echo "Previous version backed up at: $BACKUP"

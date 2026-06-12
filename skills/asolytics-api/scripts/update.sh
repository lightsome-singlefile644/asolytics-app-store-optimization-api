#!/usr/bin/env bash
#
# Update this installed asolytics-api skill to the latest version on GitHub.
# Safe to run from anywhere — it operates on the skill folder this script lives in.
#
#   bash scripts/update.sh
#
set -euo pipefail

REPO="https://github.com/Asolytics-Pro/asolytics-app-store-optimization-api.git"
SUBDIR="skills/asolytics-api"

# The installed skill folder = parent of this script's directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

OLD_VERSION="$(cat "$SKILL_DIR/VERSION" 2>/dev/null || echo "unknown")"

command -v git >/dev/null 2>&1 || { echo "git is required to update." >&2; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Fetching latest asolytics-api skill from GitHub..."
git clone --quiet --depth 1 "$REPO" "$TMP"

if [ ! -d "$TMP/$SUBDIR" ]; then
  echo "Could not find $SUBDIR in the repository. Aborting." >&2
  exit 1
fi

# Back up the current install, then overlay the latest files in place.
BACKUP="${SKILL_DIR}.bak"
rm -rf "$BACKUP"
cp -R "$SKILL_DIR" "$BACKUP"
cp -R "$TMP/$SUBDIR/." "$SKILL_DIR/"

NEW_VERSION="$(cat "$SKILL_DIR/VERSION" 2>/dev/null || echo "unknown")"
echo "Updated asolytics-api: $OLD_VERSION -> $NEW_VERSION"
echo "Previous version backed up at: $BACKUP"

#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$ROOT/VERSION"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION="$1"
TAG="v$VERSION"
NOTES="$ROOT/RELEASE_NOTES_v$VERSION.md"

[ -f "$VERSION_FILE" ] || { echo "ERROR: VERSION missing"; exit 1; }
[ -f "$NOTES" ] || { echo "ERROR: $NOTES missing"; exit 1; }
command -v gh >/dev/null || { echo "ERROR: GitHub CLI gh is required"; exit 1; }

CURRENT="$(tr -d '[:space:]' < "$VERSION_FILE")"
[ "$CURRENT" = "$VERSION" ] || { echo "ERROR: VERSION mismatch"; exit 1; }

cd "$ROOT"
[ -z "$(git status --porcelain)" ] || { echo "ERROR: working tree is not clean"; exit 1; }
[ "$(git branch --show-current)" = "main" ] || { echo "ERROR: checkout main first"; exit 1; }

git fetch origin main --tags
[ "$(git rev-parse HEAD)" = "$(git rev-parse origin/main)" ] || {
  echo "ERROR: local main differs from origin/main"
  exit 1
}

git rev-parse "$TAG" >/dev/null 2>&1 || { echo "ERROR: local tag $TAG missing"; exit 1; }
[ "$(git rev-list -n 1 "$TAG")" = "$(git rev-parse HEAD)" ] || {
  echo "ERROR: $TAG does not point to current main"
  exit 1
}
git ls-remote --exit-code --tags origin "refs/tags/$TAG" >/dev/null 2>&1 || {
  echo "ERROR: remote tag $TAG missing"
  exit 1
}
if gh release view "$TAG" >/dev/null 2>&1; then
  echo "ERROR: release $TAG already exists"
  exit 1
fi

gh release create "$TAG" \
  --verify-tag \
  --title "Selenium Serenity Automation Framework $TAG" \
  --notes-file "$NOTES" \
  --latest

gh release view "$TAG"

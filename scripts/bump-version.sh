#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$PROJECT_ROOT/VERSION"

usage() {
    echo "Usage: $0 major|minor|patch|<explicit-version>"
}

if [ "$#" -ne 1 ]; then
    usage
    exit 1
fi

if [ ! -f "$VERSION_FILE" ]; then
    echo "ERROR: VERSION file is missing"
    exit 1
fi

CURRENT_VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"
REQUESTED="$1"
SEMVER_REGEX='^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$'

if [[ ! "$CURRENT_VERSION" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    echo "ERROR: Automatic bump requires a stable current version"
    exit 1
fi

MAJOR="${BASH_REMATCH[1]}"
MINOR="${BASH_REMATCH[2]}"
PATCH="${BASH_REMATCH[3]}"

case "$REQUESTED" in
    major) NEW_VERSION="$((MAJOR + 1)).0.0" ;;
    minor) NEW_VERSION="$MAJOR.$((MINOR + 1)).0" ;;
    patch) NEW_VERSION="$MAJOR.$MINOR.$((PATCH + 1))" ;;
    *) NEW_VERSION="$REQUESTED" ;;
esac

if [[ ! "$NEW_VERSION" =~ $SEMVER_REGEX ]]; then
    echo "ERROR: Invalid target version: $NEW_VERSION"
    exit 1
fi

if [ "$NEW_VERSION" = "$CURRENT_VERSION" ]; then
    echo "ERROR: Target version is unchanged: $NEW_VERSION"
    exit 1
fi

printf '%s\n' "$NEW_VERSION" > "$VERSION_FILE"
echo "Updated VERSION: $CURRENT_VERSION -> $NEW_VERSION"

if [ -f "$PROJECT_ROOT/pom.xml" ] && command -v mvn >/dev/null 2>&1; then
    (
        cd "$PROJECT_ROOT"
        mvn versions:set -DnewVersion="$NEW_VERSION" -DgenerateBackupPoms=false --batch-mode --no-transfer-progress
    )
    echo "Updated Maven project version to $NEW_VERSION"
fi

echo "Review with: git diff"
echo "Validate with: ./scripts/check-version.sh"

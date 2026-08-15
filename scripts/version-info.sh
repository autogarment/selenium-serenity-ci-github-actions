#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$PROJECT_ROOT/VERSION"

if [ ! -f "$VERSION_FILE" ]; then
    echo "ERROR: VERSION file is missing"
    exit 1
fi

VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"

echo "Repository version: $VERSION"
echo "Git tag:            v$VERSION"

if [ -f "$PROJECT_ROOT/pom.xml" ] && command -v mvn >/dev/null 2>&1; then
    MAVEN_VERSION="$(
        cd "$PROJECT_ROOT"
        mvn help:evaluate -Dexpression=project.version -q -DforceStdout 2>/dev/null | tail -n 1
    )"
    echo "Maven version:      ${MAVEN_VERSION:-unknown}"
fi

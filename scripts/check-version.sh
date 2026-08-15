#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$PROJECT_ROOT/VERSION"
POM_FILE="$PROJECT_ROOT/pom.xml"
SEMVER_REGEX='^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$'

if [ ! -f "$VERSION_FILE" ]; then
    echo "ERROR: VERSION file is missing"
    exit 1
fi

VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"

if [[ ! "$VERSION" =~ $SEMVER_REGEX ]]; then
    echo "ERROR: Invalid Semantic Version: $VERSION"
    exit 1
fi

echo "PASS: VERSION contains a valid Semantic Version: $VERSION"

if [ ! -f "$POM_FILE" ]; then
    echo "WARNING: pom.xml was not found; Maven version comparison skipped"
    exit 0
fi

if ! command -v mvn >/dev/null 2>&1; then
    echo "WARNING: Maven is unavailable; Maven version comparison skipped"
    exit 0
fi

MAVEN_VERSION="$(
    cd "$PROJECT_ROOT"
    mvn help:evaluate -Dexpression=project.version -q -DforceStdout 2>/dev/null | tail -n 1
)"

if [ -z "$MAVEN_VERSION" ]; then
    echo "ERROR: Could not determine Maven project version"
    exit 1
fi

if [ "$VERSION" != "$MAVEN_VERSION" ]; then
    echo "ERROR: Version mismatch"
    echo "VERSION: $VERSION"
    echo "pom.xml: $MAVEN_VERSION"
    exit 1
fi

echo "PASS: VERSION and pom.xml both use $VERSION"

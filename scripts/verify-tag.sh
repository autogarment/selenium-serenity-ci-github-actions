#!/usr/bin/env bash
set -Eeuo pipefail
VERSION=$(tr -d '[:space:]' < VERSION)
TAG=${GITHUB_REF_NAME:-$(git describe --tags --exact-match 2>/dev/null || true)}
TAG=${TAG#v}
[ "$VERSION" = "$TAG" ] || { echo "VERSION and tag mismatch"; exit 1; }
echo "Tag verification PASSED"

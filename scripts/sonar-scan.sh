#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SONAR_HOST_URL="${SONAR_HOST_URL:-http://localhost:9000}"
SONAR_PROJECT_KEY="${SONAR_PROJECT_KEY:-selenium-serenity-ci}"
SONAR_QUALITY_GATE_WAIT="${SONAR_QUALITY_GATE_WAIT:-true}"
SONAR_QUALITY_GATE_TIMEOUT="${SONAR_QUALITY_GATE_TIMEOUT:-300}"
TEST_TAGS="${TEST_TAGS:-@all}"
BROWSER="${TEST_BROWSER:-chrome}"
HEADLESS="${TEST_HEADLESS:-true}"

if [[ -z "${SONAR_TOKEN:-}" ]]; then
  echo "ERROR: SONAR_TOKEN is not set." >&2
  echo "Create a SonarQube token and export it:" >&2
  echo "  export SONAR_TOKEN='squ_...'" >&2
  exit 1
fi

"$ROOT/scripts/sonar-wait.sh"

echo "=========================================="
echo " Phase 6.0.2 - SonarQube scan"
echo "=========================================="
echo "Server       : $SONAR_HOST_URL"
echo "Project key  : $SONAR_PROJECT_KEY"
echo "Test tags    : $TEST_TAGS"
echo "Quality Gate : wait=$SONAR_QUALITY_GATE_WAIT"
echo

mvn \
  --batch-mode \
  --no-transfer-progress \
  clean verify \
  org.sonarsource.scanner.maven:sonar-maven-plugin:5.5.0.6356:sonar \
  "-Dcucumber.filter.tags=$TEST_TAGS" \
  "-Dtags=$TEST_TAGS" \
  "-Dwebdriver.driver=$BROWSER" \
  "-Dheadless=$HEADLESS" \
  "-Dsonar.host.url=$SONAR_HOST_URL" \
  "-Dsonar.token=$SONAR_TOKEN" \
  "-Dsonar.projectKey=$SONAR_PROJECT_KEY" \
  "-Dsonar.qualitygate.wait=$SONAR_QUALITY_GATE_WAIT" \
  "-Dsonar.qualitygate.timeout=$SONAR_QUALITY_GATE_TIMEOUT"

echo
echo "SonarQube analysis complete:"
echo "  $SONAR_HOST_URL/dashboard?id=$SONAR_PROJECT_KEY"

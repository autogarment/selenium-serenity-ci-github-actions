#!/usr/bin/env bash
set -euo pipefail

SONAR_HOST_URL="${SONAR_HOST_URL:-http://localhost:${SONAR_PORT:-9000}}"
TIMEOUT_SECONDS="${SONAR_WAIT_TIMEOUT:-240}"
STARTED_AT=$(date +%s)

echo "Waiting for SonarQube at $SONAR_HOST_URL ..."

while true; do
  STATUS="$(curl -fsS "$SONAR_HOST_URL/api/system/status" 2>/dev/null || true)"

  if grep -q '"status":"UP"' <<<"$STATUS"; then
    echo "SonarQube status: UP"
    exit 0
  fi

  NOW=$(date +%s)
  if (( NOW - STARTED_AT >= TIMEOUT_SECONDS )); then
    echo "ERROR: SonarQube did not become ready within ${TIMEOUT_SECONDS}s." >&2
    echo "Check logs with:" >&2
    echo "  docker compose -f docker-compose.sonar.yml logs sonarqube" >&2
    exit 1
  fi

  sleep 5
done

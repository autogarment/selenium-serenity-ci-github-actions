#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ ! -f .env.sonar ]]; then
  cp .env.sonar.example .env.sonar
  echo "Created .env.sonar from .env.sonar.example"
fi

docker compose --env-file .env.sonar -f docker-compose.sonar.yml up -d
"$ROOT/scripts/sonar-wait.sh"

echo
echo "SonarQube is ready: http://localhost:${SONAR_PORT:-9000}"
echo "First login: admin / admin (change the password immediately)."

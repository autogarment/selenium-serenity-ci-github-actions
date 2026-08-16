# Selenium Serenity CI Automation Framework

[![UI Automation Tests](https://github.com/OWNER/selenium-basic/actions/workflows/selenium-ci.yml/badge.svg?branch=main)](https://github.com/OWNER/selenium-basic/actions/workflows/selenium-ci.yml)
![Java](https://img.shields.io/badge/Java-21-blue) ![Maven](https://img.shields.io/badge/Maven-Build-orange) ![Selenium](https://img.shields.io/badge/Selenium-WebDriver-green) ![Serenity BDD](https://img.shields.io/badge/Serenity-BDD-16a085) ![Cucumber](https://img.shields.io/badge/Cucumber-BDD-23d96c)

Enterprise-style UI automation demo using Java 21, Selenium, Cucumber, Serenity BDD, JaCoCo and GitHub Actions.

## Phase 6.0.1 - JaCoCo Coverage

Phase 6.0.1 adds JaCoCo execution data and report generation without enforcing a coverage threshold yet.

Expected outputs after `mvn clean verify`:

```text
target/jacoco.exec
target/site/jacoco/index.html
target/site/jacoco/jacoco.xml
```

Important: the current automation framework keeps its Java implementation under `src/test/java`. The standard JaCoCo Maven report normally measures classes from `src/main/java`, so JaCoCo execution data can be generated while the HTML/XML report is empty or unavailable. This is intentionally not a build blocker in Phase 6.0.1. Coverage scope will be refined before SonarQube quality gating in Phase 6.0.2.

## CI strategy

| Trigger | Target | Suite | Publish Pages |
|---|---|---|---|
| Pull request | `develop` or `main` | `@smoke` | No |
| Push | `develop` | `@regression` | No |
| Push | `main` | `@regression` | Optional |
| Manual | Selected branch | Selected tags | Optional on `main` |

GitHub Pages is deliberately excluded from the Phase 6.0.1 quality gate. To enable Pages later, configure the repository Pages source as **GitHub Actions** and create repository variable:

```text
ENABLE_GITHUB_PAGES=true
```

If this variable is absent, Pages preparation/deployment is skipped and cannot fail the Selenium/JaCoCo pipeline.

## Run locally

Recommended CI-compatible command:

```bash
chmod +x scripts/*.sh
./scripts/run-ci.sh chrome true @smoke
```

Equivalent Maven command:

```bash
mvn clean verify \
  -Dcucumber.filter.tags="@smoke" \
  -Dtags="@smoke" \
  -Dwebdriver.driver=chrome \
  -Dheadless=true \
  -Dchrome.switches="--headless=new,--no-sandbox,--disable-dev-shm-usage,--disable-gpu,--window-size=1920,1080"
```

## Reports

The pipeline can produce:

- Serenity BDD report: `target/site/serenity/index.html`
- JaCoCo execution data: `target/jacoco.exec`
- JaCoCo HTML report: `target/site/jacoco/index.html`
- JaCoCo XML report for SonarQube: `target/site/jacoco/jacoco.xml`
- Optional Allure, Masterthought, dashboard and report portal outputs when their generator scripts exist
- `maven-ci.log` in the diagnostic artifact when CI execution fails

## Troubleshooting CI failures

When GitHub Actions reports multiple downstream errors, inspect this artifact first:

```text
test-diagnostics-<run-id>/maven-ci.log
```

The Maven/Selenium failure is the root cause when Serenity, JaCoCo and other reports are all missing.

## Documentation

- [Architecture](docs/architecture.md)
- [CI/CD pipeline](docs/ci-cd-pipeline.md)
- [Test strategy](docs/test-strategy.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Contributing](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)

## Phase 6.0.2 - SonarQube Quality Gate

Local SonarQube Community environment:

```bash
cp .env.sonar.example .env.sonar
systemctl --user restart docker-desktop
docker compose --env-file .env.sonar -f docker-compose.sonar.yml down
docker rm -f selenium-serenity-sonarqube \
  selenium-serenity-sonar-db
./scripts/sonar-start.sh
```

Create a SonarQube token, then run the complete quality scan:

```bash
####./scripts/sonar-start.sh trước khi chạy scan
export SONAR_TOKEN='squ_03c8517e7947f362738dcb92da9cfa75990ef643'
export TEST_TAGS='@all'
./scripts/sonar-scan.sh

```

Outputs used by SonarQube:

```text
target/site/jacoco/index.html
target/site/jacoco/jacoco.xml
target/site/jacoco/jacoco.csv
```

Full guide: `docs/phase-6.0.2-sonarqube.md`.

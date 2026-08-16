# Phase 6.0.2 - SonarQube Quality Gate

## Goal

Pipeline after this phase:

```text
Selenium / Serenity
        |
        v
      JaCoCo
        |
        v
   jacoco.xml
        |
        v
 SonarQube Scan
        |
        v
  Quality Gate
        |
   PASS / FAIL
```

SonarQube does not generate Java test coverage itself. JaCoCo runs first and SonarQube imports `target/site/jacoco/jacoco.xml`.

## Local architecture

```text
Ubuntu 22
  |
  +-- Maven / Java 21 / Chrome
  |
  +-- Docker Compose
       |
       +-- SonarQube Community :9000
       |
       +-- PostgreSQL 16
```

## Start local SonarQube

```bash
cp .env.sonar.example .env.sonar
./scripts/sonar-start.sh
```

Open `http://localhost:9000`.

Initial local credentials are `admin / admin`; SonarQube asks you to change the password.

## Create token

In SonarQube:

```text
User avatar
 -> My Account
 -> Security
 -> Generate Tokens
```

Example token name:

```text
selenium-serenity-local
```

Then export the generated token in the shell:

```bash
export SONAR_TOKEN='YOUR_TOKEN'
```

Do not commit it to Git.

## Run Phase 6.0.2 locally

```bash
export SONAR_HOST_URL='http://localhost:9000'
export SONAR_TOKEN='YOUR_TOKEN'
export TEST_TAGS='@all'

./scripts/sonar-scan.sh
```

The script executes `clean verify` first so JaCoCo XML exists before SonarScanner runs, and waits for the Quality Gate result.

## Why `actions` and `pages` moved to `src/main/java`

Before Phase 6.0.2 the whole Selenium framework lived under `src/test/java`, which meant Maven considered it test code and JaCoCo's standard `report` goal had no production classes under `target/classes` to report on.

The framework is now split as:

```text
src/main/java/com/automation/
  actions/   <- reusable workflow/business interaction layer
  pages/     <- reusable UI mapping layer

src/test/java/com/automation/
  runners/
  steps/
```

JaCoCo excludes `pages/**` from coverage. Coverage therefore focuses on the action layer rather than CSS/XPath mappings.

## GitHub Actions integration

GitHub-hosted runners cannot access `http://localhost:9000` on your Ubuntu machine.

To enable SonarQube analysis in GitHub Actions, the SonarQube server must be reachable from the runner, for example:

- a server/VM with a public or private reachable URL;
- a self-hosted GitHub Actions runner on the same network (later enterprise phase).

Repository settings:

```text
Settings
 -> Secrets and variables
 -> Actions
```

Repository variable:

```text
ENABLE_SONAR=true
SONAR_HOST_URL=https://sonar.example.com
SONAR_PROJECT_KEY=selenium-serenity-ci
```

Repository secret:

```text
SONAR_TOKEN=<token>
```

Keep `ENABLE_SONAR=false` or unset while only using SonarQube on localhost.

## Quality Gate behavior

The scanner is invoked with:

```text
-Dsonar.qualitygate.wait=true
```

That means analysis success alone is insufficient. If SonarQube returns a failed Quality Gate, the Sonar step fails too.

## Stop local environment

```bash
./scripts/sonar-stop.sh
```

Do not normally use `sonar-reset.sh`; it deletes local SonarQube/PostgreSQL volumes.

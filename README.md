# Selenium Serenity CI Automation Framework

[![UI Automation Tests](https://github.com/OWNER/selenium-basic/actions/workflows/selenium-ci.yml/badge.svg?branch=main)](https://github.com/OWNER/selenium-basic/actions/workflows/selenium-ci.yml)
![Java](https://img.shields.io/badge/Java-21-blue) ![Maven](https://img.shields.io/badge/Maven-Build-orange) ![Selenium](https://img.shields.io/badge/Selenium-WebDriver-green) ![Serenity BDD](https://img.shields.io/badge/Serenity-BDD-16a085) ![Cucumber](https://img.shields.io/badge/Cucumber-BDD-23d96c)

Enterprise-style UI automation demo using Java 21, Selenium, Cucumber and Serenity BDD with GitHub Actions and GitHub Pages.

## Live report

[Open the latest Serenity report](https://autogarment.github.io/selenium-basic/serenity/)

## CI strategy

| Trigger | Target | Suite | Publish Pages |
|---|---|---|---|
| Pull request | `develop` or `main` | `@smoke` | No |
| Push | `develop` | `@regression` | No |
| Push | `main` | `@regression` | Yes |
| Manual | Selected branch | Selected tags | Only on `main` |


## Run locally

```bash
mvn clean verify \
  -Dcucumber.filter.tags="@smoke" \
  -Dtags="@smoke" \
  -Dwebdriver.driver=chrome \
  -Dheadless=true \
  -Dchrome.switches="--headless=new,--no-sandbox,--disable-dev-shm-usage,--disable-gpu,--window-size=1920,1080"
```

Open `target/site/serenity/index.html`.

## Documentation

- [Architecture](docs/architecture.md)
- [CI/CD pipeline](docs/ci-cd-pipeline.md)
- [Test strategy](docs/test-strategy.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Contributing](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)

## Reports

The automation pipeline generates:

- Serenity BDD Report
- Allure Report
- Masterthought Cucumber Report
- Automation Dashboard
- GitHub Pages Report Portal
- JaCoCo Coverage Report

### JaCoCo

Local report:

```text
target/site/jacoco/index.html
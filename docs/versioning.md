# Versioning Policy

This project follows Semantic Versioning:

```text
MAJOR.MINOR.PATCH
```

## Version rules

### MAJOR

Increase the MAJOR version when a change is not backward compatible.

Examples:

- Restructure the automation framework in a way that requires existing tests to be rewritten.
- Remove or rename public configuration properties.
- Replace the execution or reporting architecture.

Example:

```text
1.4.2 -> 2.0.0
```

### MINOR

Increase the MINOR version when adding backward-compatible functionality.

Examples:

- Add Firefox or Edge support.
- Add a Selenium Grid execution mode.
- Add Allure or another reporting output.
- Add a new reusable testing capability.

Example:

```text
1.4.2 -> 1.5.0
```

### PATCH

Increase the PATCH version for backward-compatible fixes.

Examples:

- Fix a GitHub Actions workflow.
- Fix a locator or assertion.
- Correct report generation.
- Improve documentation without changing the public framework contract.

Example:

```text
1.4.2 -> 1.4.3
```

## Version source of truth

The root `VERSION` file is the repository version source of truth.

The Maven project version in `pom.xml` must match `VERSION`.

```text
VERSION = 1.0.0
pom.xml = 1.0.0
Git tag = v1.0.0
GitHub Release = v1.0.0
```

## Pre-release versions

Supported pre-release forms:

```text
1.1.0-alpha.1
1.1.0-beta.1
1.1.0-rc.1
```

## Release branch policy

```text
develop -> release/1.0.0 -> main
```

After merge into `main`, create the tag:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## Version update workflow

```bash
./scripts/bump-version.sh patch
./scripts/bump-version.sh minor
./scripts/bump-version.sh major
```

Always review the generated diff before committing.

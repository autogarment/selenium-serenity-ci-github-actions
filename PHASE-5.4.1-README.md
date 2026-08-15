# Phase 5.4.1 — Semantic Versioning

## Included files

```text
VERSION
docs/versioning.md
scripts/version-info.sh
scripts/check-version.sh
scripts/bump-version.sh
CHANGELOG-PHASE-5.4.1.md
```

## Apply

Copy the files into the project while preserving paths, then run:

```bash
chmod +x scripts/version-info.sh scripts/check-version.sh scripts/bump-version.sh
mvn versions:set -DnewVersion=1.0.0 -DgenerateBackupPoms=false
./scripts/check-version.sh
./scripts/version-info.sh
```

Recommended branch:

```bash
git checkout develop
git pull origin develop
git checkout -b release/1.0.0
```

Commit:

```bash
git add VERSION pom.xml docs/versioning.md scripts/ CHANGELOG.md
git commit -m "chore(release): prepare version 1.0.0"
git push -u origin release/1.0.0
```

Do not create tag `v1.0.0` yet. Tag creation belongs to Phase 5.4.2 after CI passes and the release branch is merged into `main`.

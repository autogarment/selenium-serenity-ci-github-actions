# CI/CD Pipeline

PRs run smoke tests. Pushes to `develop` run regression without deployment. Pushes to `main` run regression, verify Serenity, create `target/github-pages`, upload the Pages artifact and deploy it.

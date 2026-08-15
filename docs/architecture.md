# Architecture

```text
Feature files → Step definitions → Page objects/tasks → Selenium → Chrome → Serenity results → HTML report
```

CI uses Java 21, Maven, Selenium, Serenity BDD, Cucumber, GitHub Actions and GitHub Pages. Failed tests still publish diagnostics; only successful `main` runs update the live report.

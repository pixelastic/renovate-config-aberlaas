# `renovate-config-aberlaas`

This is shared Renovate config that is mostly used by projects created using
[aberlaas][1].

## Usage

In your `.github/renovate.json` file, for example:

```json
{
  "extends": ["config:js-lib", "github>pixelastic/renovate-config-aberlaas"]
}
```

Renovate reads the preset from `default.json` on the `main` branch of this
repository. Pushing to `main` is enough to update every project.

## Preset

`default.json` contains the main options that you should enable on all aberlaas
projects.

- Automatically rebase PRs when they are behind the base branch
- Create commits following the `chore(keyword): description` pattern
- Add some fairly large limit to the number of concurrent jobs
- Set all timezones to Paris
- Only update dependencies between 1am and 5am
- Automerge `minor` and `patch` updates in a branch, without a PR
- Do not update docker image, CircleCI orbs, node and yarn versions
- Group updates of my own modules, of norska and of netlify

[1]: https://github.com/pixelastic/aberlaas/

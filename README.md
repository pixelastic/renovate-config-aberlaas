# `renovate-config-aberlaas`

This is shared Renovate config that is mostly used by projects created using
[aberlaas][1].

## Presets

### `default`

This contains the main options that you should enable on all aberlaas projects.

- Automatically rebase PRs when they are stale
- Create commits following the `type(keyword): description` pattern
- Add some fairly large limit to the number of concurrent jobs
- Set all timezones to Paris
- Do not update docker image in `.circleci/config.yml`

### `automergeSilently`

This will attempt at merging `patch` and `minor` updates silently in a branch in
the background and then merging that branch into master. If the merge somehow
fails, a PR will be created to inspect the issue.

This is the recommended setting as it will keep updating non-breaking changes in
dependencies without human intervention and only ask for review when tests are
failing.

### `scheduleAtAnyTime`

This will attempt to merge updates as soon as they are discovered. This works
really well with the `automergeSilently` feature as most of the time the updates
will happen invisibly in the background.

### `enableMasterIssue`

_Turned off by default_

This will create a master issue in the "Issues" tab referencing all the
currently opened PRs, along with a checkbox to force a rebase. This tends to
clutter the display so has been turned off.

### `automergePublicly`

_Turned off by default_

This will create a PR for each `minor` and `patch` update, asking for human
verification before merging. This was enabled at first to double check what was
going on, but has been turned off now that everything sails smoothly. It's still
here for debugging purposes.

### `sheduleAtNight`

_Turned off by default_

Will only attempt merging updates out of work hours. This can be useful when
coupled with `automergePublicly` to reduce the noise from notification, but is
mostly useless otherwise.

## Usage

In your `.github/renovate.json` file, for example:

```json
{
  "extends": [
    "config:js-lib",
    "aberlaas",
    "aberlaas:automergeSilently",
    "aberlaas:scheduleAtAnyTime"
  ]
}
```

## Release

Run `yarn run release {major|minor|patch}` to release a new version. Aberlaas
uses the latest deployed version

[1]: https://github.com/pixelastic/aberlaas/

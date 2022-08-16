# Github Actions Test
Repository used to test GitHub actions

## github-action-bump-version

The `bump-version` action can be used to update the `major`, `minor`, or `patch` portion of a semantic version number.  It is also possible to bump the *build* portion of a tagged semantic version.  E.G. `1.2.3-anvil.4` -> `1.2.3-anvil.5`

The version number to be updated can be any yaml-ish like file with a `version` field that begins at the start of the line.  
```yaml
version: 1.2.3
```
or in a `VERSION` file that contains a sinlge line of text with the version number
```
1.2.3
```

See [ksuderman/github-action-bump-version](https://github.com/ksuderman/github-action-bump-version) for full usage information or the [.github/workflows/version.yml](https://github.com/ksuderman/github-actions-test/blob/master/.github/workflows/version.yml) file in this repository to see how the action was implement for this repository.

### Usage

1. Create a new branch from the `dev` branch.
   ```
   git checkout dev
   git checkout -b my-branch`
   ```
1. Modify a file
   ```
   echo foo >> README.md
   ```
1. Commit and push the change to your new branch
   ```
   git add README.md
   git commit -m "Updated the readme"
   git push origin my-branch
   ```
1. Create a pull request to merge your branch (my-branch) into the `dev` branch. Label the PR with one of `major`, `minor`, `patch` to indicate which segment of the version number to be bumped.
   ```
   gh pr create --label patch --base dev --head my-branch --body "Updated the README with important information --title "Update README"
   ```
1. Merge the pull request.
   ```
   gh pr merge N --merge --body "Test update of the README" --delete-branch
   ```
   Where `N` is the pull request number as returned by the `gh pr create` command.
   
## github-action-tag-release

The `tag-release` action extracts the current version from a yaml-ish like file or a VERSION file, creates a tag with that version number and publishes a GitHub release. See [ksuderman/github-action-tag-release](https://github.com/ksuderman/github-action-tag-release) or the [.github/workflows/release.yml](https://github.com/ksuderman/github-actions-test/blob/master/.github/workflows/release.yml) file to see how the action was configured for this repository.

### Usage

1. Create a pull request to merge the `dev` branch into `master`
   ```
   gh pr create --base master --head dev --title "Release X" --body "Rolling a new release"
   ```
1. Merge the pull request.
   ```
   gh pr merge N --merge --body "The next release"
   ```
   Where `N` is the pull request number as returned by the `gh pr create` command.

**Note** we do not need to add a `label` or configure anything else.  This action just needs to be triggered by a relevant GitHub event, e.g. merging into master.

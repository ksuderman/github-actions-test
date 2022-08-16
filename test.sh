#!/usr/bin/env bash

set -eu

name=$1

git checkout -b $name
echo $name >> README.md
git add README.md
git commit -m "$name"
git push origin $name
git checkout dev
pr=$(gh pr create --base dev --head $name --title $name --body $name --label minor | tail -1)
gh pr merge $pr --rebase --body $name --delete-branch

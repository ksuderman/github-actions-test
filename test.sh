#!/usr/bin/env bash

name=$1
label=${2:-minor}

set -eu

# Create a new branch
git checkout -b $name

# Make a change
echo $name >> README.md

# Commit and push the change
git add README.md
git commit -m "$name"
git push origin $name
git checkout dev

# Create a PR
pr=$(gh pr create --base dev --head $name --title $name --body $name --label $label | tail -1)

#  And immediately merge it.
gh pr merge $pr --rebase --body $name --delete-branch
git pull origin dev

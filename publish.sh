#!/bin/sh

echo "Deleting old publication"
rm -rf _site
mkdir _site
git worktree prune
rm -rf .git/worktrees/_site/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages _site upstream/gh-pages

echo "Removing existing files"
rm -rf _site/*

echo "Generating site"
bundle exec jekkyl build

echo "Updating gh-pages branch"
cd _site && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"

#echo "Pushing to github"
git push upstream/gh-pages

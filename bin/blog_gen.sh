#! /usr/bin/env bash

set -eou pipefail

BLOG_TITLE="Minor Gripe"
BLOG_DIRECTORY="$HOME/writing/blog"
BLOG_BUILD_PATH="$HOME/writing/_build/.blog_output"
BLOG_FILES_PATH="$HOME/writing/_build/.blog_files"
BLOG_URL="https://www.minor.gripe"
BLOG_DESCRIPTION="Assorted writings on life, engineering, and software."
BLOG_POSTS_ROOT="https://www.minor.gripe/posts/"
BLOG_STYLES="$HOME/.blog/styles.css"

PROD_HOSTNAME="minor.gripe"
PROD_USER="crertel"
PROD_BLOG_PATH="/home/crertel/blog"
PROD_TEMP_ARTIFACT="$(mktemp).tar.gz"

ZAMRAZAC_PATH="$HOME/projects/zamrazac"

mkdir -p "$BLOG_DIRECTORY"
mkdir -p "$BLOG_BUILD_PATH"
mkdir -p "$BLOG_FILES_PATH"

pushd() {
    command pushd "$@" >/dev/null
}

popd() {
    command popd "" >/dev/null
}

pushd "$ZAMRAZAC_PATH"
BLOG_STYLES="$BLOG_STYLES" BLOG_URL="$BLOG_URL" BLOG_DESCRIPTION="$BLOG_DESCRIPTION" BLOG_POSTS_ROOT="$BLOG_POSTS_ROOT" BLOG_TITLE="$BLOG_TITLE" BLOG_DIRECTORY="$BLOG_DIRECTORY" OUTPUT_DIRECTORY="$BLOG_BUILD_PATH" mix zamrazac.generate
popd

set -x

rsync -a "$BLOG_FILES_PATH" "$BLOG_BUILD_PATH/files"
tar -czf "$PROD_TEMP_ARTIFACT" --exclude "./images" -C "$BLOG_BUILD_PATH" .
scp "$PROD_TEMP_ARTIFACT" "$PROD_USER@$PROD_HOSTNAME:$PROD_BLOG_PATH/deploy.tar.gz"
rm "$PROD_TEMP_ARTIFACT"
ssh "$PROD_USER@$PROD_HOSTNAME" tar -xf "$PROD_BLOG_PATH/deploy.tar.gz" -C "$PROD_BLOG_PATH"

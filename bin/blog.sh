#!/usr/bin/env bash

set -eou pipefail

BLOG_AUTHOR="Chris Ertel"
BLOG_DIRECTORY="$HOME/writing/blog"
BLOG_BUILD_PATH="$HOME/writing/_build/.blog_output"
ZAMRAZAC_PATH="$HOME/projects/zamrazac"

BLOG_TITLE="$@"

mkdir -p "$BLOG_DIRECTORY"
mkdir -p "$BLOG_BUILD_PATH"

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "" > /dev/null
}

pushd "$ZAMRAZAC_PATH"
BLOG_DIRECTORY="$BLOG_DIRECTORY" \
BLOG_AUTHOR="$BLOG_AUTHOR" \
mix zamrazac.create "$BLOG_TITLE" | grep -oP "^OUTPUT: \K.*$" | xargs "$EDITOR"
popd

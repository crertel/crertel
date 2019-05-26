#! /bin/bash

set -eou pipefail

BLOG_TITLE="Swizzled Bits"
BLOG_DIRECTORY="$HOME/.blog"
BLOG_BUILD_PATH="$HOME/.blog_output"
ZAMRAZAC_PATH="$HOME/projects/zamrazac"

mkdir -p "$BLOG_DIRECTORY"
mkdir -p "$BLOG_BUILD_PATH"

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "" > /dev/null
}

pushd "$ZAMRAZAC_PATH"
BLOG_TITLE="$BLOG_TITLE" BLOG_DIRECTORY="$BLOG_DIRECTORY" OUTPUT_DIRECTORY="$BLOG_BUILD_PATH" mix zamrazac.generate
popd
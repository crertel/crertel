#! /usr/bin/env bash

set -eou pipefail

BLOG_TITLE="Minor Gripe"
BLOG_DIRECTORY="$HOME/writing/blog"
BLOG_PREVIEW_BASE=$(mktemp -d -t "zamrazac-preview-XXXXXXXXXX")
BLOG_BUILD_PATH="$BLOG_PREVIEW_BASE/blog_output"
BLOG_URL="https://www.minor.gripe"
BLOG_DESCRIPTION="Assorted writings on life, engineering, and software."
BLOG_POSTS_ROOT="https://www.minor.gripe/posts/"
BLOG_STYLES="$HOME/writing/blog/styles.css"

ZAMRAZAC_PATH="$HOME/projects/zamrazac"

mkdir -p "$BLOG_DIRECTORY"
mkdir -p "$BLOG_BUILD_PATH"


pushd() {
    command pushd "$@" >/dev/null
}

popd() {
    command popd "" >/dev/null
}

pushd "$ZAMRAZAC_PATH"
BLOG_STYLES="$BLOG_STYLES" BLOG_URL="$BLOG_URL" BLOG_DESCRIPTION="$BLOG_DESCRIPTION" BLOG_POSTS_ROOT="$BLOG_POSTS_ROOT" BLOG_TITLE="$BLOG_TITLE" BLOG_DIRECTORY="$BLOG_DIRECTORY" OUTPUT_DIRECTORY="$BLOG_BUILD_PATH" mix zamrazac.generate
popd

echo "Previewing at $BLOG_BUILD_PATH..."
python -m http.server --directory "$BLOG_BUILD_PATH"
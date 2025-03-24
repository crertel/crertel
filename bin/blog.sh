#!/usr/bin/env bash

set -eou pipefail

# previews blog
BLOG_DIRECTORY="/home/crertel/writing/newblog"
BLOG_TITLE="$@"

# Get current date in YYYY-MM-DD format
CURRENT_DATE=$(date +"%Y-%m-%d")

# Slugify the title (lowercase, replace spaces with hyphens, remove special chars)
SLUG=$(echo "$BLOG_TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g' | sed 's/[^a-z0-9_-]//g')

# Combine date and slug
BUNDLE_NAME="${CURRENT_DATE}-${SLUG}"

# Path where the bundle will be created
BUNDLE_PATH="content/posts/${BUNDLE_NAME}"

{
    cd "$BLOG_DIRECTORY"

    # Create the page bundle
    hugo new --kind page-bundle "posts/${BUNDLE_NAME}"

    # Ensure the directory exists
    mkdir -p "${BUNDLE_PATH}"

    # Open the index.md file in your editor
    $EDITOR "${BUNDLE_PATH}/index.md"
}

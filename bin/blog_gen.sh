#! /usr/bin/env bash

set -eou pipefail

# previews blog
BLOG_DIRECTORY="/home/crertel/writing/newblog"

{
    cd "$BLOG_DIRECTORY"
    ./deploy.sh
}

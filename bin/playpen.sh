#! /usr/bin/env bash

set -eou pipefail

# create playpen
PLAYPEN_DIR=$(mktemp -d -t "playpen-XXXXXXXX")

echo "entering playpen @ $PLAYPEN_DIR"
pushd "$PLAYPEN_DIR" > /dev/null
	$SHELL
popd > /dev/null
echo "deleting playpen @ $PLAYPEN_DIR"
rm -rv "$PLAYPEN_DIR"






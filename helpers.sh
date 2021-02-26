#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"  # Get the directory name
INCLUDE_DIR="$(readlink -f "${SCRIPT_DIR}")"    # Resolve its full path if need be
source "$INCLUDE_DIR/colors.sh"


function get_url_status() {
    curl -o /dev/null -s -w "%{http_code}\n" "$1"
}

function print_info() {
    printf "${Color_White}%s${Color_Off}" "$1"
}

function print_error() {
    printf "${Color_Red}%s${Color_Off}" "$1"
}

function print_warning() {
    printf "${Color_Yellow}%s${Color_Off}" "$1"
}

function print_success() {
    printf "${Color_Green}%s${Color_Off}" "$1"
}
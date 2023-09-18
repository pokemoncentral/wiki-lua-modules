#!/usr/bin/env bash

# This script runs all the tests, dropping stdout but not stderr. It's used to
# check for lua runtime errors.

HELP_STRING="Usage:
run-all [-h]

Runs all the tests, dropping stdout to only show lua runtime errors.

Arguments:
- h: Show this help"

#######################################
# Variables
#######################################

# This is the directory where test scripts are located. It happens to be the
# same as this script's, and it also happens to be inside the git repository
SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

#######################################
# Input processing
#######################################

while getopts 'h' OPTION; do
    case "$OPTION" in
        'h')
            echo "$HELP_STRING"
            exit 0
            ;;

        *) # getopts already printed an error message
            exit 1
            ;;
    esac
done
shift $(( OPTIND - 1 ))


for testcase in "$SCRIPTS_DIR"/*.spec.lua; do
    lua "$testcase" > /dev/null &
done
wait

#!/usr/bin/env bash

# This script is used as a pre-commit hook to run test for changed lua files.
# It mostly just maps source lua files to their integration test
#
# Arguments:
#   - $@: Changed lua sources

#######################################
# Variables
#######################################

# This is the directory where test scripts are located. It happens to be the
# same as this script's, and it also happens to be inside the git repository
TESTS_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

# Colored output
RESET='\e[0m'
GREEN='\e[92m'

########################################
# Main
########################################

[ "$#" -eq 0 ] && exit 0

basename --multiple --suffix .lua "$@" | while read -r CHANGED_LUA_FILE; do
    # Removing .spec via shell substitution handles test files
    TEST_FILE="$TESTS_DIR/${CHANGED_LUA_FILE%%.spec}.spec.lua"
    if [ -f "$TEST_FILE" ]; then
        echo "$TEST_FILE"
    else
        echo -en >&2 "${GREEN}[TEST]${RESET} No tests found for "
        echo -e >&2 "${GREEN}$CHANGED_LUA_FILE.lua${RESET}"
    fi
done | xargs --no-run-if-empty bash "$TESTS_DIR/regression-test.sh"

#!/usr/bin/env bash

# This script runs snapshot test, that is it compares the current output of a
# test suite with the ones stored in the `snapshots` directory. It can also use
# the `snapshots` directory of a previous commit, or the test output from that
# commit if the `snapshots` directory wasn't there yet. For more info, read the
# help string below

HELP_STRING="Usage:
regression-test [-hp] [-c HASH] FILES...

Runs snapshot tests against one or more test files.
This script simply compares the current output of the test file with that
stored in the snapshots directory, printing differences.

Arguments:
    FILES...: The test files to be executed

Options:
    -h: Show this help
    -c: Commit to compare with. Default to HEAD
    -p: Preserve test outputs. If not specified, those are removed"

#######################################
# Variables
#######################################

# This is the directory where test scripts are located. It happens to be the
# same as this script's, and it also happens to be inside the git repository
TESTS_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

SNAPSHOTS_DIR="$TESTS_DIR/snapshots"
CURRENT_OUTPUT_DIR="$TESTS_DIR/current-output"

#######################################
# Functions
#######################################

# This function runs the provided test scripts, saving the output to a new file
# in the given output directory.
#
# Arguments:
#   - $1: The output directory to which the test output are saved
#   - $2+: The test scripts
run_tests() {
    local OUTPUT_DIR="$1"
    shift 1

    while [ $# -gt 0 ]; do
        local TEST_SCRIPT_PATH="$1"
        local TEST_SCRIPT
        TEST_SCRIPT="$(basename "$TEST_SCRIPT_PATH")"
        # [[ ! -e "$TEST_SCRIPT_PATH" ]] && {
        #     echo -ne >&2 '\e[91m[TEST]\e[0m '
        #     echo -e >&2 "\e[91m$TEST_SCRIPT\e[0m@$COMMIT not found"
        #     continue
        # }

        echo -e "\e[92m[TEST]\e[0m Running \e[92m$TEST_SCRIPT\e[0m@\e[94mcurrent\e[0m"
        lua "$TEST_SCRIPT_PATH" > "$OUTPUT_DIR/$TEST_SCRIPT.out"

        shift
    done
}

#######################################
# Input processing
#######################################

# The git commit whose test output will be compared to the current one.
COMMIT=''
# Whether output files should be kept
KEEP_OUTPUT='false'

while getopts 'hpc:' OPTION; do
    case "$OPTION" in
        'h')
            echo "$HELP_STRING"
            exit 0
            ;;

        'c')
            COMMIT="$OPTARG"
            ;;

        'p')
            KEEP_OUTPUT='true'
            ;;

        *) # getopts already printed an error message
            exit 1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

# Checking for named arguments after positional
grep -E '\s+-\w\s+' <<<"$*" > /dev/null && {
    echo >&2 "Named arguments found after positional in: $*"
    exit 1
}

########################################
# Get old commit snapshots
########################################

# if [ -n "$COMMIT" ]; then
#     SNAPSHOTS_COMMIT="$SNAPSHOTS_DIR-$COMMIT"

#     git worktree add "$SNAPSHOTS_COMMIT" "$COMMIT"
#     cd "$SNAPSHOTS_COMMIT/test/snapshot" || {
#         bash cd "$SNAPSHOTS_COMMIT/test
#     }

# fi

# #######################################
# # Going back to old git commit
# #######################################

# echo -e '\e[94m[GIT]\e[0m Stashing uncommitted changes'
# git -C "$TESTS_DIR" stash push -q
# echo -e "\e[94m[GIT]\e[0m Checking out $COMMIT"
# git -C "$TESTS_DIR" checkout -q "$COMMIT"

# #######################################
# # Running old test scripts
# #######################################

# OLD_OUTPUT_DIR="$(mktemp --tmpdir="$TESTS_DIR" -d "output-$COMMIT.XXX")"
# run_tests "$OLD_OUTPUT_DIR" "$TESTS_DIR" "$@"

# #######################################
# # Going back to current HEAD
# #######################################

# echo -e '\e[94m[GIT]\e[0m Checking back out to current HEAD'
# git -C "$TESTS_DIR" checkout -q "$CURRENT_HEAD"
# echo -e '\e[94m[GIT]\e[0m Stashing changes back'
# git -C "$TESTS_DIR" stash pop -q

#######################################
# Running current test scripts
#######################################

mkdir -p "$CURRENT_OUTPUT_DIR"
run_tests "$CURRENT_OUTPUT_DIR" "$@"

#######################################
# Diffing
#######################################

basename -a "$@" | while read -r TEST_SCRIPT; do
    echo -e "\e[93m[DIFF]\e[0m Compare \e[93m$TEST_SCRIPT\e[0m output with snapshot"
    diff -su --color=always \
        --label "$TEST_SCRIPT@snapshot" \
        --label "$TEST_SCRIPT@current" \
        "$CURRENT_OUTPUT_DIR/$TEST_SCRIPT.out" \
        "$SNAPSHOTS_DIR/$TEST_SCRIPT.out"
done

#######################################
# Cleaning up
#######################################

if [[ "$KEEP_OUTPUT" == 'false' ]]; then
    rm -rf "$OLD_OUTPUT_DIR" "$CURRENT_OUTPUT_DIR"
fi

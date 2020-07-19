#!/usr/bin/env bash

# This script runs a regression test, that is it compares the current output of
# a test file with the one of an previous git commit. For more info, read the
# help string below

HELP_STRING="Usage:
regression-test [-hp] [-c HASH] FILES...

Runs regression tests against one or more test file.
This script simply compare the current output of the test file with that of an
older (git) version, printing differences.

Arguments:
- h: Show this help
- c: Commit to compare with. Default to HEAD
- p: Preserve test outputs. If not specified, those are removed"

#######################################
# Variables
#######################################

# This is the directory where test scripts are located. It happens to be the
# same as this script's, and it also happens to be inside the git repository
SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

#######################################
# Input processing
#######################################

# The git commit whose test output will be compared to the current one.
COMMIT='HEAD~1'
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

#######################################
# Going back to old git commit
#######################################

CURRENT_HEAD="$(git rev-parse --abbrev-ref HEAD)"

echo -e '\e[94m[GIT]\e[0m Stashing uncommitted changes'
git -C "$SCRIPTS_DIR" stash push -q
echo -e "\e[94m[GIT]\e[0m Checking out $COMMIT"
git -C "$SCRIPTS_DIR" checkout -q "$COMMIT"

#######################################
# Running old test scripts
#######################################

OLD_OUTPUT_DIR="$(mktemp --tmpdir="$SCRIPTS_DIR" -d "output-$COMMIT.XXX")"
basename -a "$@" | while read TEST_SCRIPT; do
    TEST_SCRIPT_PATH="$SCRIPTS_DIR/$TEST_SCRIPT"
    [[ ! -e "$TEST_SCRIPT_PATH" ]] && {
        echo -e >&2 "\e[91m[TEST]\e[0m $TEST_SCRIPT test not found in $COMMIT"
        continue
    }

    echo -e "\e[92m[TEST]\e[0m Running $TEST_SCRIPT in $COMMIT"
    lua "$TEST_SCRIPT_PATH" > "$OLD_OUTPUT_DIR/$TEST_SCRIPT.out"
done

#######################################
# Going back to current HEAD
#######################################

echo -e '\e[94m[GIT]\e[0m Checking back out to current HEAD'
git -C "$SCRIPTS_DIR" checkout -q "$CURRENT_HEAD"
echo -e '\e[94m[GIT]\e[0m Stashing changes back'
git -C "$SCRIPTS_DIR" stash pop -q

CURRENT_OUTPUT_DIR="$(mktemp --tmpdir="$SCRIPTS_DIR" \
    -d "output-$CURRENT_HEAD.XXX")"
for TEST_SCRIPT in "$@"; do
    TEST_SCRIPT="$(basename "$TEST_SCRIPT")"
    lua "$SCRIPTS_DIR/$TEST_SCRIPT" > "$CURRENT_OUTPUT_DIR/$TEST_SCRIPT.out"
done

#######################################
# Diffing
#######################################

basename -a "$@" | while read TEST_SCRIPT; do
    echo -ne "\e[93m[DIFF]\e[0m Comparing files \e[93m$TEST_SCRIPT\e[0m@"
    echo -ne "\e[94m$CURRENT_HEAD\e[0m and \e[93m$TEST_SCRIPT\e[0m@"
    echo -e "\e[94m$COMMIT\e[0m"
    diff -su --color=always \
        --label "$TEST_SCRIPT@$CURRENT_HEAD" \
        --label "$TEST_SCRIPT@$COMMIT" \
        "$CURRENT_OUTPUT_DIR/$TEST_SCRIPT.out" \
        "$OLD_OUTPUT_DIR/$TEST_SCRIPT.out"
done

#######################################
# Cleaning up
#######################################

if [[ "$KEEP_OUTPUT" == 'false' ]]; then
    rm -rf "$OLD_OUTPUT_DIR" "$CURRENT_OUTPUT_DIR"
fi

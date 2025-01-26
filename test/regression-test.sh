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

# Colored output
RESET='\e[0m'
BLUE='\e[94m'
GREEN='\e[92m'
RED='\e[91m'
YELLOW='\e[93m'

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
    local COMMIT="$2"
    shift 2

    while [ $# -gt 0 ]; do
        local TEST_SCRIPT_PATH="$1"
        local TEST_SCRIPT
        TEST_SCRIPT="$(basename "$TEST_SCRIPT_PATH")"
        shift

        [ ! -f "$TEST_SCRIPT_PATH" ] && {
            echo -ne >&2 "${GREEN}[TEST]${RESET} ${RED}$TEST_SCRIPT${RESET}@"
            echo -e >&2 "${BLUE}$COMMIT${RESET} not found"
            continue
        }

        echo -ne "${GREEN}[TEST]${RESET} Running "
        echo -e "${GREEN}$TEST_SCRIPT${RESET}@${BLUE}$COMMIT${RESET}"
        lua "$TEST_SCRIPT_PATH" > "$OUTPUT_DIR/$TEST_SCRIPT.out"
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

[ -n "$COMMIT" ] && {
    COMMIT_SHA="$(git rev-parse --short "$COMMIT")"
    WORKTREE_FOR_COMMIT="$TESTS_DIR/worktree-$COMMIT_SHA"

    git worktree list --porcelain | grep --quiet "$WORKTREE_FOR_COMMIT" || {
        rm --recursive --force "$WORKTREE_FOR_COMMIT"
        git worktree add "$WORKTREE_FOR_COMMIT" "$COMMIT" > /dev/null
    }

    # shellcheck disable=SC2064
    [ "$KEEP_OUTPUT" == 'false' ] \
        && trap "git worktree remove --force $WORKTREE_FOR_COMMIT" EXIT

    GIT_ROOT="$(git rev-parse --show-toplevel)"
    SNAPSHOTS_DIR="$WORKTREE_FOR_COMMIT/${SNAPSHOTS_DIR##"$GIT_ROOT"}"

    if [ -d "$SNAPSHOTS_DIR" ]; then
        echo -ne "${GREEN}[TEST]${RESET} Use ${YELLOW}snapshots${RESET} "
        echo -e "from ${BLUE}$COMMIT${RESET}"
    else
        echo -ne "${GREEN}[TEST]${RESET} Snapshots@${BLUE}$COMMIT${RESET} not "
        echo 'found. Execute tests.'

        mkdir -p "$SNAPSHOTS_DIR"
        TESTS_IN_WORKTREE="$(readlink -f "$@" \
            | sed "s|^$GIT_ROOT|$WORKTREE_FOR_COMMIT|")"
        # shellcheck disable=SC2086
        run_tests "$SNAPSHOTS_DIR" "$COMMIT" $TESTS_IN_WORKTREE
    fi
}

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
run_tests "$CURRENT_OUTPUT_DIR" 'current' "$@"

#######################################
# Diffing
#######################################

basename -a "$@" | while read -r TEST_SCRIPT; do
    echo -ne "${YELLOW}[DIFF]${RESET} Compare ${YELLOW}$TEST_SCRIPT${RESET} "
    echo 'output with snapshot'
    diff -su --color=always \
        --label "$TEST_SCRIPT@snapshot" \
        --label "$TEST_SCRIPT@current" \
        "$CURRENT_OUTPUT_DIR/$TEST_SCRIPT.out" \
        "$SNAPSHOTS_DIR/$TEST_SCRIPT.out"
done

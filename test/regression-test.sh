#!/usr/bin/env bash

# This script runs snapshot test, that is it compares the current output of a
# test suite with the ones stored in the `snapshots` directory. It can also use
# snapshots from a previous commit. For more info, read the help string below.

HELP_STRING="Usage:
regression-test [-hp] [-c GIT-REF] FILES...

Runs snapshot tests against one or more test files.
This script simply compares the current output of the test files with that
stored in the snapshots directory, printing differences.

If a commit is provided via the -c option, the snapshots from such commits are
used. If the commit doesn't have snapshots, they are generated on-the-fly by
executing tests at that commit.
Snapshots/test output of previous commits are cleaned up after each run of the
script. If the -p option is given, they are kept around under
test/worktree-<commit-sha>.

Arguments:
    FILES...: The test files to be executed. If none is given, all test will be
              executed.

Options:
    -h:             Show this help
    -c GIT-REF:     Commit ref from which snapshots are used. If not given, the
                    snapshots *currently on the filesystem* are used.
    -p:             Preserve snapshots from the commit provided by -c. If not
                    specified, the snapshots are removed
"

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
GRAY='\e[90m'
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
# Whether to update snapshots
UPDATE_SNAPSHOTS='false'

while getopts 'hpc:u' OPTION; do
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

        'u')
            UPDATE_SNAPSHOTS='true'
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

TEST_FILES=( "$@" )
[ "${#TEST_FILES}" -eq 0 ] && {
    TEST_FILES=( "$TESTS_DIR"/*.spec.lua )
}

########################################
# Update snapshots
########################################

# We don't support updating snapshots from a previous commit yet. Hence, we
# handle updating here before dealing with old commits and exit early.
[ "$UPDATE_SNAPSHOTS" == 'true' ] && {
    run_tests "$SNAPSHOTS_DIR" 'current' "${TEST_FILES[@]}"
    echo -e "${YELLOW}[UPDATE]${RESET} Snapshot updated"
    exit 0
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

#######################################
# Running current test scripts
#######################################

mkdir -p "$CURRENT_OUTPUT_DIR"
run_tests "$CURRENT_OUTPUT_DIR" 'current' "${TEST_FILES[@]}"

#######################################
# Diffing
#######################################

EXIT_CODE=0

while read -r TEST_SCRIPT; do
    echo -ne "${YELLOW}[DIFF]${RESET} Compare ${YELLOW}$TEST_SCRIPT${RESET} "
    echo 'output with snapshot'
    diff -su --color=always \
        --label "$TEST_SCRIPT@snapshot" \
        --label "$TEST_SCRIPT@current" \
        "$SNAPSHOTS_DIR/$TEST_SCRIPT.out" \
        "$CURRENT_OUTPUT_DIR/$TEST_SCRIPT.out" \
        || EXIT_CODE=1
done < <(basename -a "${TEST_FILES[@]}")

[ "$EXIT_CODE" -ne 0 ] && {
    echo -ne "${GREEN}[TEST]${RESET} Some tests produced different output than"
    echo -n " the snapshot. If the current output is what's expected, you can "
    echo 'update the snapshots by mens of'
    echo -en "${GREEN}[TEST]${RESET}"
    echo -e "     ${GRAY}bash $0 -u [TEST-FILE...]${RESET}"
}

exit "$EXIT_CODE"

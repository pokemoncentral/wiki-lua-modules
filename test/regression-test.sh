#!/bin/bash

COMMIT="HEAD~1"
PFLAG=false
BASEDIR=""

while getopts "hpc:" OPTION; do
    case $OPTION in
        h)
            echo "Usage:
regression-test [-hp] [-c HASH] FILES...

Runs regression tests against one or more test file.
This script runs simply compare the current output of the test file with
that of an older (git) version, printing differences.
Should be run from the wiki-lua-modules directory or one of its subdirs.

Arguments:
    - h: Show this help
    - c: Commit to compare with. Default to HEAD~1
    - p: Preserve old outputs. If not specified, those are removed"
            exit 0
            ;;
        c)
            COMMIT="$OPTARG"
            ;;
        p)
            PFLAG=true
            ;;
        *) # getopts already printed an error message
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

# This script should be ran in the correct working dir. I can't ensure it, but
# at least allow a minimum flexibility
if ! [[ $(basename $(pwd)) == "wiki-lua-modules" ]]; then
    cd ..
    BASEDIR="test"
fi

# Go to the older version
HEAD=$(git rev-parse --abbrev-ref HEAD)
git stash
git checkout "$COMMIT" > /dev/null 2>&1

for f in "$@"; do
    echo "Running $f"
    lua "${BASEDIR}/${f}" > "${BASEDIR}/${f}.out"
done

# Return to current work environment
git checkout "$HEAD" > /dev/null 2>&1
git stash pop > /dev/null

for f in "$@"; do
    echo "========================= Differences of $f ========================="
    lua "${BASEDIR}/${f}" | diff --color=always "${BASEDIR}/${f}.out" -
    if ! [[ $PFLAG == true ]]; then
        rm "${BASEDIR}/${f}.out"
    fi
done

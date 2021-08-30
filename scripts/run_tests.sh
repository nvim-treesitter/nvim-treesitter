#!/usr/bin/env bash

HERE="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
cd $HERE/..

run() {
    nvim --headless --noplugin -u scripts/minimal_init.lua \
        -c "PlenaryBustedDirectory $1 { minimal_init = './scripts/minimal_init.lua' }"
}

if [[ $1 = '--summary' ]]; then
    # really simple results summary by filtering plenary busted output
    run tests/indent/ 2> /dev/null | grep -E '^\S*(Success|Fail(ed)?|Errors?)'
elif [[ $1 = '--unit' ]]; then
    run tests/unit
else
    run tests/indent/
fi

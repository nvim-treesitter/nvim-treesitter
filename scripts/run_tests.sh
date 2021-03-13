#!/usr/bin/env bash

HERE="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
cd $HERE/..

nvim --headless --noplugin -u scripts/minimal_init.lua \
  -c "PlenaryBustedDirectory lua/tests/indent/ { minimal_init = './scripts/minimal_init.lua' }"

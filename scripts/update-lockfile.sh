#!/usr/bin/env bash

if [ -n "$1" ]
then
  TO_IGNORE=$(jq -r "keys | map(if . != \"$1\" then . else \"\" end) | @csv" -c lockfile.json)
fi

SKIP_LOCKFILE_UPDATE_FOR_LANGS="$TO_IGNORE,$SKIP_LOCKFILE_UPDATE_FOR_LANGS" nvim --headless -c "luafile ./scripts/write-lockfile.lua" -c "q"
# Pretty print
cp lockfile.json /tmp/lockfile.json
cat /tmp/lockfile.json | jq --sort-keys > lockfile.json

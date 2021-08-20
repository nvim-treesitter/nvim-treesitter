#!/bin/sh

make_ignored() {
  if [ -n "$1" ]
  then
    jq keys < lockfile.json | tail --line=+2 | head --lines=-1 | tr -d "\" ," | while read lang
    do
      if [ "$lang" != "$1" ]
      then
        printf "$lang,"
      fi
    done
  fi
}

TO_IGNORE=$(make_ignored $1)

SKIP_LOCKFILE_UPDATE_FOR_LANGS="$TO_IGNORE" nvim --headless -c "luafile ./scripts/write-lockfile.lua" -c "q"
# Pretty print
cp lockfile.json /tmp/lockfile.json
cat /tmp/lockfile.json | jq --sort-keys > lockfile.json

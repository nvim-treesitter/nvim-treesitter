#!/usr/bin/env bash

# ignore indent test files
luacheck `find -name  "*.lua" -not -path "./lua/tests/indent/lua/*"` --codes

#!/bin/bash

BARE_PATH="${1%.*}"
as -g "${BARE_PATH}.s" -o "${BARE_PATH}.o"
ld "${BARE_PATH}.o" -o ./bin/$BARE_PATH
exec ./bin/$BARE_PATH

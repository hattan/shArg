#!/usr/bin/env bash

source scripts/shArg.sh

declare MESSAGE

messageHook() {
  local message=$1

  echo "message hooked invoked with $message"
  echo "Global variable is still available $MESSAGE"
}

# register arguments
shArgs.arg "MESSAGE" -m --message messageHook

# parse inputs
shArgs.parse "$@"



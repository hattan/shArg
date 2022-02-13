#!/usr/bin/env bash

# #########################################################
# Navigate to the examples folder and invoke this file.
# cd examples
# ./simple_example.sh -m hello -d
# #########################################################

# load shArg
source ../scripts/shArg.sh

declare MESSAGE

# Declare a hook method to fire when the message argument is found
# Hook methods allow you to run a piece of code for additional behaviors when an argument is bound
messageHook() {
  local message=$1

  echo "message hooked invoked with $message"
  echo "Global variable is still available $MESSAGE"

}

# register arguments
shArgs.arg "MESSAGE" -m --message PARAMETER true messageHook

# parse inputs
shArgs.parse "$@"



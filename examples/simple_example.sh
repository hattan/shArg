#!/usr/bin/env bash

# #########################################################
# Navigate to the examples folder and invoke this file.
# cd examples
# ./simple_example.sh -m hello -d
# #########################################################

# load shArg
source ../scripts/shArg.sh

declare MESSAGE
declare DEBUG

messageHook() {
  local message=$1

  echo "message hooked invoked with $message"
  echo "Global variable is still available $MESSAGE"
}


# register arguments
shArgs.arg "MESSAGE" -m --message PARAMETER true messageHook

# parse inputs
shArgs.parse "$@"

# echo "The message is $MESSAGE"

# if [ "$DEBUG" == true ]; then
#   echo "DEBUG is true!"
# else
#   echo "DEBUG is false"
# fi

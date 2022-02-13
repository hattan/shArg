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

# register arguments
shArgs.arg "MESSAGE" -m --message PARAMETER true
shArgs.arg "DEBUG" -d --debug FLAG true

# parse inputs
shArgs.parse "$@"

echo "The message is $MESSAGE"

if [ "$DEBUG" == true ]; then
  echo "DEBUG is true!"
else
  echo "DEBUG is false"
fi

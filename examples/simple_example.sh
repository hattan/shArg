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
shArgs.arg "MESSAGE" -m --message 
shArgs.arg "DEBUG" -d --debug 

# parse inputs
shArgs.parse "$@"

echo "The message is $MESSAGE"
echo "The message is $(shArgs.val "MESSAGE")" 

if [ "$DEBUG" == true ]; then
  echo "DEBUG is true!"
else
  echo "DEBUG is false"
fi

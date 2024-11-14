#!/usr/bin/env bash

# #########################################################
# registering an argument
# shARgs.arg "<key: string>" "<short flag name: -string>" "<long flag name: --string>" "<type: PARAMETER | FLAG>" "<auto export: true | false"
#
# Run this script with
# ./examples.sh -f 1234 -b -m 12123 -d aaa -n bbb
# #########################################################

# load shArg
source ../scripts/shArg.sh

# define a parmeter (input with value)
shArgs.arg "MESSAGE" -m --message 

# define a boolean flag (no value required)
# if invoked without a value then it's assumed to be a FLAG and will return true/false.
# eg ./script.sh -m "test" will have a value of "test"
# eg ./script.sh -d will have a value of true
shArgs.arg "DEBUG" -d --debug

# you can define an arg with only a short name
shArgs.arg "NAME" -n

# you can define an arg with only a long name
shArgs.arg "OUTPUT" --output

# you can auto export a value to a global variable
# For auto exported values, you must define all inputs
declare FILE
shArgs.arg "FILE" -f --file PARAMETER true 

# Parse inputs
shArgs.parse "$@"

# assign the value to a variable
declare message='shArgs.val "MESSAGE"'
echo "message   = $message"

# Reference values directly from the _SH_ARGUMENTs array
echo "DEBUG     = ${_SH_ARGUMENTS["DEBUG"]}"
echo "NAME      = ${_SH_ARGUMENTS["NAME"]}"

# auto exported value to Global variable
echo "FILE      = $FILE"


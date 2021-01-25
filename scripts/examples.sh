#!/usr/bin/env bash

# load shArg
source shArg.sh

# ####
# registering an argument
# shARgs.arg "<key: string>" "<short flag name: -string>" "<long flag name: --string>" "<type: PARAMETER | FLAG>" "<auto export: true | false"
#
# Run this script with
# ./examples.sh -f 1234 -b -m 12123 -d aaa --coo bbb
# ###

# define a parmeter (input with value)
shArgs.arg "MESSAGE" -m --message PARAMETER 

# define a boolean flag (no value required)
shArgs.arg "DEBUG" -d --debug FLAG

# if omitted PARAMETER is the default
shArgs.arg "USER" -u --user 

# you can define an arg with only a short name
shArgs.arg "NAME" -n

# you can define an arg with only a long name
shArgs.arg "OUTPUT" --output

# you can auto export a value to a global variable
# For auto exported values, you must define all inputs
declare FILE
shArgs.arg "FILE" -f --file PARAMETER true 


# Parse inputs
shArgs.parse $@

# assign the value to a variable
declare message=`shArgs.val "MESSAGE"`
echo "message   = $message"

# Reference values directly from the _SH_ARGUMENTs array
echo "DEBUG     = ${_SH_ARGUMENTS["DEBUG"]}"
echo "USER      = ${_SH_ARGUMENTS["USER"]}"
echo "NAME      = ${_SH_ARGUMENTS["NAME"]}"
echo "OUTPUT    = ${_SH_ARGUMENTS["OUTPUT"]}"

# auto exported value to Global variable
echo "FILE      = $FILE"


#!/usr/bin/env bash

# #########################################################
# Navigate to the examples folder and invoke this file.
# cd examples
# ./list.sh -i 1.1.1.1,2.2.2.2
# #########################################################

# load shArg
source ../scripts/shArg.sh

declare IPS

# register arguments
shArgs.arg "IPS" -i --ips PARAMETER true 

# parse inputs
shArgs.parse "$@"

for ip in $IPS
do
    echo "ip: $ip"
done

# Expected Output
# $ ./list.sh -i 1.1.1.1,2.2.2.2
# ip: 1.1.1.1
# ip: 2.2.2.2

#!/usr/bin/env bash

source scripts/shArg.sh

declare IPS
shArgs.arg "IPS" -i --ips PARAMETER true 
shArgs.parse $@

for ip in $IPS
do
    echo "ip: $ip"
done

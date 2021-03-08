#!/usr/bin/env bash

declare SH_ARG_BASE=.sh_arg

if [ ! -d $SH_ARG_BASE ]; then
  mkdir .sh_arg
fi

if [ ! -f "$SH_ARG_BASE/shArg.sh" ]; then
    wget --directory-prefix=$SH_ARG_BASE https://raw.githubusercontent.com/hattan/shArg/0.3.0/scripts/shArg.sh 
fi

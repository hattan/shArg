shopt -s expand_aliases

SH_ARG_BASE=.sh_arg

if [ ! -d $SH_ARG_BASE ]; then
  mkdir .sh_arg
fi

if [ ! -f "$SH_ARG_BASE/shArg.sh" ]; then
    wget --quiet --directory-prefix=$SH_ARG_BASE https://raw.githubusercontent.com/hattan/shArg/main/scripts/shArg.sh
fi

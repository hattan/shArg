#!/usr/bin/env bash

run_file() {
  local file=$1
  local input=$2
  output=$(bash $file $input)
  echo $output
}
#!/usr/bin/env bash
set -e
DIR=$(pwd)
for i in $(ls tests); do 
  cd "$DIR/tests/$i";
  echo "Testing $i"
  terraform init -backend=false > /dev/null
  terraform test
done;
echo "Done testing"
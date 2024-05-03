#!/usr/bin/env bash
set -e
DIR=$(pwd)
for i in $(ls examples); do
  cd "$DIR/examples/$i";
  echo "Validating $i"
  terraform init -backend=false > /dev/null
  terraform validate
done;
echo "Done validating"
#!/usr/bin/env bash
#

set -e
DIR=$(pwd)
DOCS_DIR=docs/docs
find $DOCS_DIR -name '*.md' -delete
n=1
for g in $(ls -d */); do
  if [[ "$g" == "tests/" ]]; then continue; fi
  if [[ "$g" == "docs/" ]]; then continue; fi
  g=$(echo $g | sed 's:/*$::')
  for m in $(ls $DIR/$g); do
    printf -v nn "%03d" $n
    terraform-docs -c .terraform.docs.yml $DIR/$g/$m >> $DOCS_DIR/${nn}_${g}_${m}.md
    ((n++))
  done;
done;
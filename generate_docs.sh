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
    FILENAME=$DOCS_DIR/${nn}_${g}_${m}.md
    cat > $FILENAME <<EOL
---
layout: page
title:  ${g}/${m}
---

EOL
    terraform-docs -c .terraform.docs.yml $DIR/$g/$m >> $FILENAME
    ((n++))
  done;
done;
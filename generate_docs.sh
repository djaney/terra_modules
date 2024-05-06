#!/usr/bin/env bash
set -e
# Generate docs
DIR="$(pwd)/src"
DOCS_DIR=docs/_docs
find $DOCS_DIR -name '*.md' -delete
n=1
for g in $(ls $DIR); do
  for m in $(ls $DIR/$g); do
    printf -v nn "%03d" $n
    FILENAME=$DOCS_DIR/${nn}_${g}_${m}.md
    CONTENT=""
FRONT_MATTER=$(cat <<EOL
---
title: ${g}/${m}
permalink: docs/${g}/${m}
layout: default
---
EOL)
    if [[ -f $DIR/$g/$m/readme.md ]]; then
      CONTENT=$(cat $DIR/$g/$m/readme.md)
    fi
    cat > $FILENAME <<EOL
${FRONT_MATTER}
${CONTENT}
EOL
    terraform-docs -c .terraform.docs.yml $DIR/$g/$m >> $FILENAME
    ((n++))
  done;
done;

# Examples
DIR="$(pwd)/examples"
DOCS_DIR=docs/_examples
find $DOCS_DIR -name '*.md' -delete
n=1
for g in $(ls $DIR); do
  printf -v nn "%03d" $n
  FILENAME=$DOCS_DIR/${nn}_${g}.md
  CONTENT=""
  FRONT_MATTER=$(cat <<EOL
---
title: ${g}
permalink: examples/${g}
layout: default
---
EOL)
  if [[ -f $DIR/$g/readme.md ]]; then
    CONTENT=$(cat $DIR/$g/readme.md)
  fi
  if [[ -f $DIR/$g/example.tf ]]; then
    EXAMPLE=$(cat $DIR/$g/example.tf)
  fi
  cat > $FILENAME <<EOL
${FRONT_MATTER}
${CONTENT}
\`\`\`
${EXAMPLE}
\`\`\`
EOL
    ((n++))
done;

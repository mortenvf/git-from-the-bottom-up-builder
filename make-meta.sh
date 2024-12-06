#!/bin/bash

SCRIPT_DIR=$(realpath -e $(dirname "$0"))

pushd git-from-the-bottom-up >/dev/null

AUTHOR_DATE=$(git log -1 --date=format:'%Y-%m-%d' --format="%cd")

mkdir -p "$SCRIPT_DIR/build" 2>/dev/null

cat >"$SCRIPT_DIR/build/metadata.yml" <<EOF
---
title: "Git from the Bottom Up"
author: "John Wiegley"
date: $AUTHOR_DATE
keywords:
description: "Introduction to the world of the powerful content tracking system called Git."
rights: CC BY-ND 4.0
language: en-US
documentclass: book
links-as-notes: true
verbatim-in-note: true
...
EOF

popd >/dev/null
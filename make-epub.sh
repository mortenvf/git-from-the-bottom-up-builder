#!/bin/bash

SCRIPT_DIR=$(realpath -e $(dirname "$0"))
mkdir -p build 2>/dev/null

pushd git-from-the-bottom-up >/dev/null
pandoc \
        --from=markdown+smart \
		--from=markdown+rebase_relative_paths \
		-t epub3 \
        -o "$SCRIPT_DIR/build/git-from-the-bottom-up.epub" \
		"$SCRIPT_DIR/build/metadata.yml" \
        index.md \
		1-Repository/*.md \
		2-The-Index/*.md \
		3-Reset/*.md \
		4-Stashing-and-the-reflog.md \
		5-Conclusion.md \
		6-Further-Reading.md
popd >/dev/null

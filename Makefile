#!/usr/bin/make -f

.ONESHELL:
SHELL:=/bin/bash
G:="git-from-the-bottom-up"
PANDOC_IMG:=pandoc/latex:latest

all: build/git-from-the-bottom-up.pdf build/git-from-the-bottom-up.epub

build:
	mkdir -p build

build/metadata.yml: build
	AUTHOR_DATE="$(git -C git-from-the-bottom-up log -1 --date=format:'%Y-%m-%d' --format="%cd")"
	echo "---" >build/metadata.yml
	cat >>build/metadata.yml <<EOF
	title: "Git from the Bottom Up"
	author: "John Wiegley"
	date: ${AUTHOR_DATE}
	keywords:
	description: "Introduction to the world of the powerful content tracking system called Git."
	rights: CC BY-ND 4.0
	language: en-US
	documentclass: book
	links-as-notes: true
	verbatim-in-note: true
	...
	EOF

build/git-from-the-bottom-up.pdf: build/metadata.yml
	docker run \
		--rm \
		--volume "./:/data" \
		--workdir "/data/" \
		--user $(id -u):$(id -g) \
		${PANDOC_IMG} \
	        --from=markdown+smart \
			--from=markdown+rebase_relative_paths \
			-t pdf \
	        -o build/$G.pdf \
			build/metadata.yml \
			$G/index.md \
			$G/1-Repository/*.md \
			$G/2-The-Index/*.md \
			$G/3-Reset/*.md \
			$G/4-Stashing-and-the-reflog.md \
			$G/5-Conclusion.md \
			$G/6-Further-Reading.md

build/git-from-the-bottom-up.epub: build/metadata.yml
	docker run \
		--rm \
		--volume "./:/data" \
		--workdir "/data/" \
		--user $(id -u):$(id -g) \
		${PANDOC_IMG} \
        	--from=markdown+smart \
			--from=markdown+rebase_relative_paths \
			-t epub3 \
        	-o build/$G.epub \
			build/metadata.yml \
			$G/index.md \
			$G/1-Repository/*.md \
			$G/2-The-Index/*.md \
			$G/3-Reset/*.md \
			$G/4-Stashing-and-the-reflog.md \
			$G/5-Conclusion.md \
			$G/6-Further-Reading.md

clean:
	rm -rf build
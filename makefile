.PHONY: build clean dev env help release

GIT_VERSION := $(shell git describe --abbrev=4 --dirty --always --tags)

IMAGE:=parente/blog:latest

SITE_AUTHOR:=Jewell Thomas
SITE_NAME:=Jewell Thomas - Research
SITE_DOMAIN:=jewellthomas.github.io

help:
	@echo 'Setup - make env'
	@echo 'Render - make build'
	@echo 'Inspect - make server'
	@echo 'Release - make clean release'

clean:
	@rm -rf _output

env:
	@docker build --rm -t $(IMAGE) .

build:
	@docker run -it --rm \
		-e SITE_AUTHOR='$(SITE_AUTHOR)' \
		-e SITE_NAME="$(SITE_NAME)" \
		-e SITE_DOMAIN='http://$(SITE_DOMAIN)' \
		-v `pwd`:/srv/blog \
		$(IMAGE) python generate.py

release: build
	@cd _output && \
		git init && \
		git remote add upstream 'https://github.com/jewellthomas/pages.git' && \
		git fetch --depth=1 upstream gh-pages && \
		git reset upstream/gh-pages && \
		git add -A . && \
		git commit -m "Release $(GIT_VERSION)" && \
		git push upstream HEAD:gh-pages

dev:
	@docker run -it --rm  \
		-e SITE_AUTHOR='$(SITE_AUTHOR)' \
		-e SITE_NAME="$(SITE_NAME)" \
		-e SITE_DOMAIN='http://$(SITE_DOMAIN)' \
		-v `pwd`:/srv/blog -p 8000:8000 $(IMAGE) /bin/bash
		
server:
	@open http://localhost:8000/_output && python -m SimpleHTTPServer 8000


DOCKER_IMAGE_ZONDAX=zondax/builder-bolos
DOCKER_IMAGE_LEDGER=zondax/ledger-app-builder

INTERACTIVE:=$(shell [ -t 0 ] && echo 1)

ifdef INTERACTIVE
INTERACTIVE_SETTING:="-i"
TTY_SETTING:="-t"
else
INTERACTIVE_SETTING:=
TTY_SETTING:=
endif

ifdef HASH
HASH_TAG:=$(HASH)
else
HASH_TAG:=latest
endif

default: build

build_push: push

prepare_build:
	docker buildx create --use

build_zondax: prepare_build
	cd src && docker buildx build --platform=linux/amd64,linux/arm64 -t $(DOCKER_IMAGE_ZONDAX):$(HASH_TAG) -t $(DOCKER_IMAGE_ZONDAX):latest .

build_ledger: prepare_build
	cd ledger-app-builder && docker buildx build --platform=linux/amd64,linux/arm64 -t $(DOCKER_IMAGE_LEDGER):$(HASH_TAG) -t $(DOCKER_IMAGE_LEDGER):latest .

build: build_zondax build_ledger

push:
	docker login
	docker buildx create --use
	cd src && docker buildx build --platform=linux/amd64,linux/arm64 -t $(DOCKER_IMAGE_ZONDAX):$(HASH_TAG) -t $(DOCKER_IMAGE_ZONDAX):latest --push .
	cd ledger-app-builder && docker buildx build --platform=linux/amd64,linux/arm64 -t $(DOCKER_IMAGE_LEDGER):$(HASH_TAG) -t $(DOCKER_IMAGE_LEDGER):latest --push .

pull:
	docker pull $(DOCKER_IMAGE_ZONDAX):$(HASH_TAG)
	docker pull $(DOCKER_IMAGE_LEDGER):$(HASH_TAG)

define run_docker
	docker run $(TTY_SETTING) $(INTERACTIVE_SETTING) \
	--privileged \
	-u $(shell id -u):$(shell id -g) \
	-v $(shell pwd):/project \
	-e DISPLAY=$(shell echo ${DISPLAY}) \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	$(1) \
	"$(2)"
endef


shell_zondax: build_zondax
	$(call run_docker,$(DOCKER_IMAGE_ZONDAX):$(HASH_TAG),/bin/bash)

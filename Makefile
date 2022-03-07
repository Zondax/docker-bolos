DOCKER_IMAGE_PREFIX=zondax/builder-
DOCKER_IMAGE=${DOCKER_IMAGE_PREFIX}bolos

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

build:
	docker buildx create --use
	cd src && docker buildx build --platform=linux/amd64,linux/arm64 --rm -f ./Dockerfile -t $(DOCKER_IMAGE):$(HASH_TAG) -t $(DOCKER_IMAGE):latest .

push:
	docker login
	docker push $(DOCKER_IMAGE):latest
	docker push $(DOCKER_IMAGE):$(HASH_TAG)

pull:
	docker pull $(DOCKER_IMAGE):$(HASH_TAG)

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


shell: build
	$(call run_docker,$(DOCKER_IMAGE):$(HASH_TAG),/bin/bash)

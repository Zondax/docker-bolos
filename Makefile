DOCKER_IMAGE_PREFIX=zondax/builder
DOCKER_IMAGE_BOLOS=${DOCKER_IMAGE_PREFIX}-bolos

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

build: build_bolos

build_bolos:
	cd src && docker build --rm -f Dockerfile -t $(DOCKER_IMAGE_BOLOS):$(HASH_TAG) -t $(DOCKER_IMAGE_BOLOS) .

publish_login:
	docker login
publish_bolos: build_bolos
	docker push $(DOCKER_IMAGE_BOLOS)
	docker push $(DOCKER_IMAGE_BOLOS):$(HASH_TAG)

publish: build
publish: publish_login
publish: publish_bolos

push: publish_bolos

pull:
	docker pull $(DOCKER_IMAGE_BOLOS):$(HASH_TAG)

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


shell_bolos: build_bolos
	$(call run_docker,$(DOCKER_IMAGE_BOLOS):$(HASH_TAG),/bin/bash)

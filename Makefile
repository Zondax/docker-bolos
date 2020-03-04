DOCKER_IMAGE="zondax/ledger-docker-bolos"

INTERACTIVE:=$(shell [ -t 0 ] && echo 1)

ifdef INTERACTIVE
INTERACTIVE_SETTING:="-i"
TTY_SETTING:="-t"
else
INTERACTIVE_SETTING:=
TTY_SETTING:=
endif

define run_docker
	docker run $(TTY_SETTING) $(INTERACTIVE_SETTING) --rm \
	--privileged \
	-u $(shell id -u):$(shell id -g) \
	-v $(shell pwd):/project \
	-e DISPLAY=$(shell echo ${DISPLAY}) \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	$(DOCKER_IMAGE) \
	"$(1)"
endef

build:
	docker build --rm -f Dockerfile -t $(DOCKER_IMAGE) . 
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):v1.1

publish: build
	docker login
	docker push $(DOCKER_IMAGE)

pull:
	docker pull $(DOCKER_IMAGE)

shell: build
	$(call run_docker,bash)

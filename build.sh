#!/usr/bin/env bash
docker login
docker build --rm -f Dockerfile -t zondax/builder_bolos .
docker push zondax/builder_bolos

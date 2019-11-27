#!/usr/bin/env bash
docker build --rm --build-arg REFRESH_SPECULOS -f Dockerfile -t zondax/ledger-docker-bolos .

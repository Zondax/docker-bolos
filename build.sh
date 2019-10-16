#!/usr/bin/env bash
docker login
docker build --rm -f Dockerfile -t zondax/ledger-docker-bolos .
docker push zondax/ledger-docker-bolos

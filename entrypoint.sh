#!/usr/bin/env bash
trap "exit" SIGTERM SIGINT

echo
echo "--------------------------------------"
echo "Zondax BOLOS container - zondax.ch"
echo "--------------------------------------"
echo

source /home/zondax/.cargo/env

echo "HTTP proxy started..."
/home/zondax/speculos/tools/ledger-live-http-proxy.py -v &

echo -e $(printenv | grep BOLOS)

echo
bash -c "trap 'exit' SIGTERM SIGINT; $@"

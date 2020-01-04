#!/usr/bin/env bash
echo
echo "--------------------------------------"
echo "Zondax BOLOS container - zondax.ch"
echo "--------------------------------------"
echo

source /home/test/.cargo/env

echo "HTTP proxy started..."
/home/test/speculos/tools/ledger-live-http-proxy.py -v >> /home/test/proxy.log 2>&1 &

echo -e $(printenv | grep BOLOS)

echo
bash -c "$@"

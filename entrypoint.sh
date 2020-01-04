#!/usr/bin/env bash
echo
echo "--------------------------------------"
echo "Zondax BOLOS container - zondax.ch"
echo "--------------------------------------"
echo

source /home/test/.cargo/env
/home/test/speculos/tools/ledger-live-http-proxy.py -v >> /home/test/proxy.log 2>&1 &
bash -c $@

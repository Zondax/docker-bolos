#!/usr/bin/env bash
trap "exit" SIGTERM SIGINT

echo
echo "--------------------------------------"
echo "Zondax BOLOS container - zondax.ch"
echo "--------------------------------------"
echo

export BOLOS_SDK=${!SDK_VARNAME}

echo -e $(printenv | grep BOLOS)
echo

bash -c "trap 'exit' SIGTERM SIGINT; $@"

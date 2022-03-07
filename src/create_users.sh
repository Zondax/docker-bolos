#!/bin/bash
set -e

adduser --disabled-password --gecos "" -u 1000 zondax
adduser --disabled-password --gecos "" -u 1001 zondax_ci
adduser --disabled-password --gecos "" -u 501 zondax_mac
echo "zondax_mac ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "zondax ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "zondax_ci ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
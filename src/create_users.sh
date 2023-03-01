#!/bin/bash
set -e

adduser --disabled-password --gecos "" -u 1000 zondax
adduser --disabled-password --gecos "" -u 1001 zondax_circle
adduser --disabled-password --gecos "" -u 501 zondax_mac
echo "zondax_mac ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "zondax ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "zondax_circle ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#!/bin/bash
set -e

adduser --disabled-password --gecos "" -u 501 zondax_mac
echo "zondax_mac ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

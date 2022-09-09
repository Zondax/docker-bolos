#!/bin/bash
set -e

curl https://sh.rustup.rs -sSf | bash -s -- -y
/tmp/install_rust.sh 1.63.0


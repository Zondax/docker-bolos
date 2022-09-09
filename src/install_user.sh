#!/bin/bash
set -e

curl https://sh.rustup.rs -sSf | bash -s -- -y
/tmp/install_rust.sh 1.61.1         # Install rust 1.61.0 (required by substrate apps)

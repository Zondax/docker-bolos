#!/bin/bash
set -e

# Install ghr
go install github.com/tcnksm/ghr@latest

curl https://sh.rustup.rs -sSf | bash -s -- -y
#/tmp/install_rust.sh 1.47.0         # Install rust 1.47 (required by zcash apps)
#/tmp/install_rust.sh 1.49.0         # Install rust 1.49 (required by substrate apps)
#/tmp/install_rust.sh 1.51.0         # Install rust 1.51 (required by substrate apps)
#/tmp/install_rust.sh 1.53.0         # Install rust 1.53 (required by substrate apps)
/tmp/install_rust.sh 1.61.0          # Install rust 1.61.0 (required by substrate apps)

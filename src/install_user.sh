#!/bin/bash
set -e

# Install ghr
go get -u -v github.com/tcnksm/ghr

curl https://sh.rustup.rs -sSf | bash -s -- -y
#/tmp/install_rust.sh 1.47.0         # Install rust 1.47 (required by zcash apps)
#/tmp/install_rust.sh 1.49.0         # Install rust 1.49 (required by substrate apps)
/tmp/install_rust.sh 1.51.0         # Install rust 1.51 (required by substrate apps)

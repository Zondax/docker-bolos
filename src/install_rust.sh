#!/bin/bash
set -e
. $HOME/.cargo/env && rustup toolchain install $@
. $HOME/.cargo/env && rustup target add thumbv6m-none-eabi --toolchain $@
. $HOME/.cargo/env && rustup target add thumbv8m.main-none-eabi --toolchain $@
. $HOME/.cargo/env && rustup component add rustfmt --toolchain $@
. $HOME/.cargo/env && rustup component add clippy --toolchain $@
. $HOME/.cargo/env && rustup default $@

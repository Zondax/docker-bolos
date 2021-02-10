#!/bin/bash
set -e
. $HOME/.cargo/env && rustup toolchain install $@
. $HOME/.cargo/env && rustup target add thumbv6m-none-eabi --toolchain $@
. $HOME/.cargo/env && rustup default $@

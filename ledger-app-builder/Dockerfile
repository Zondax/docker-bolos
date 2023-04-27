FROM ghcr.io/ledgerhq/ledger-app-builder/ledger-app-builder:latest

RUN apk add bear # allows compile_commands.json generation

# for rust-based apps
RUN rustup target add thumbv6m-none-eabi
RUN rustup target add thumbv8m.main-none-eabi
RUN rustup component add rust-src

RUN RUSTFLAGS="-Ctarget-feature=-crt-static" cargo install bindgen-cli

ADD entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]

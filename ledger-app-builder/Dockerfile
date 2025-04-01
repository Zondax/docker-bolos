FROM ghcr.io/ledgerhq/ledger-app-builder/ledger-app-builder:latest

RUN apt-get update && apt-get install -y bear clang libclang-dev && rm -rf /var/lib/apt/lists/* # allows compile_commands.json generation

# for rust-based apps
RUN rustup target add thumbv6m-none-eabi
RUN rustup target add thumbv8m.main-none-eabi
RUN rustup component add rust-src

ADD entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]

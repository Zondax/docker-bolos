#!/bin/bash
set -e

DEST=/opt/bolos

rm -rf ${DEST} || true
mkdir -p ${DEST}
cd ${DEST}

wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-aarch64-linux.tar.bz2
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/clang+llvm-12.0.0-aarch64-linux-gnu.tar.xz

sha256sum clang+llvm-12.0.0-aarch64-linux-gnu.tar.xz
sha256sum gcc-arm-none-eabi-10-2020-q4-major-aarch64-linux.tar.bz2

echo "d05f0b04fb248ce1e7a61fcd2087e6be8bc4b06b2cc348792f383abf414dec48  clang+llvm-12.0.0-aarch64-linux-gnu.tar.xz" | sha256sum --check
echo "343d8c812934fe5a904c73583a91edd812b1ac20636eb52de04135bb0f5cf36a  gcc-arm-none-eabi-10-2020-q4-major-aarch64-linux.tar.bz2" | sha256sum --check

echo "decompress gcc..."
tar xfj gcc-arm-none-eabi-10-2020-q4-major-aarch64-linux.tar.bz2
echo "decompress clang..."
tar xf clang+llvm-12.0.0-aarch64-linux-gnu.tar.xz

mv clang+llvm-12.0.0-aarch64-linux-gnu clang-arm-fropi
chmod 757 -R clang-arm-fropi/
chmod +x clang-arm-fropi/bin/clang

ln -s ${DEST}/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
ln -s ${DEST}/clang-arm-fropi/bin/clang /usr/bin/clang

# Avoid high UID/GID that affect CircleCI
chown root:root /opt/bolos -R

echo "export BOLOS_ENV=/opt/bolos" >> ~/.bashrc

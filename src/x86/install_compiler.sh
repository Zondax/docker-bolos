#!/bin/bash
set -e

DEST=/opt/bolos

rm -rf ${DEST} || true
mkdir -p ${DEST}
cd ${DEST}

wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz

sha256sum clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz
sha256sum gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2

echo "a9ff205eb0b73ca7c86afc6432eed1c2d49133bd0d49e47b15be59bbf0dd292e  clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz" | sha256sum --check
echo "21134caa478bbf5352e239fbc6e2da3038f8d2207e089efc96c3b55f1edcd618  gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2" | sha256sum --check

echo "decompress gcc..."
tar xfj gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
echo "decompress clang..."
tar xf clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz

mv clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04 clang-arm-fropi
chmod 757 -R clang-arm-fropi/
chmod +x clang-arm-fropi/bin/clang

ln -s ${DEST}/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
ln -s ${DEST}/clang-arm-fropi/bin/clang /usr/bin/clang

# Avoid high UID/GID that affect CircleCI
chown root:root /opt/bolos -R

echo "export BOLOS_ENV=/opt/bolos" >> ~/.bashrc

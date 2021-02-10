#!/bin/bash
set -e

DEST=/opt/bolos

rm -rf ${DEST} || true
mkdir -p ${DEST}
cd ${DEST}

wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
wget https://releases.llvm.org/7.0.0/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz

echo "69b85c833cd28ea04ce34002464f10a6ad9656dd2bba0f7133536a9927c660d2  clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz" | sha256sum --check
echo "217850b0f3297014e8e52010aa52da0a83a073ddec4dc49b1a747458c5d6a223  gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2" | sha256sum --check

echo "decompress gcc..."
tar xfj gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
echo "decompress clang..."
tar xf clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz

mv clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04 clang-arm-fropi
chmod 757 -R clang-arm-fropi/
chmod +x clang-arm-fropi/bin/clang

ln -s ${DEST}/gcc-arm-none-eabi-5_3-2016q1/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
ln -s ${DEST}/clang-arm-fropi/bin/clang /usr/bin/clang

# Avoid high UID/GID that affect CircleCI
chown root:root /opt/bolos -R

echo "export BOLOS_ENV=/opt/bolos" >> ~/.bashrc

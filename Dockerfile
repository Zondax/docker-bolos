#Download base ubuntu image
FROM ubuntu:16.04
RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get -y install build-essential git wget sudo
RUN apt-get update && \
    apt-get -y install python-dev python-pip python-pil python-setuptools zlib1g-dev libjpeg-dev && \
    apt-get -y install libudev-dev libusb-1.0-0-dev && \
    apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev-i386 -y > /dev/null && \
    apt-get -y install binutils-arm-none-eabi zip
ADD install_compiler.sh /tmp/install_compiler.sh
RUN /tmp/install_compiler.sh

RUN apt-get update && apt-get -y install python3 python3-pip
RUN pip3 install -U setuptools ledgerblue 
RUN pip3 install -U pillow
RUN adduser --disabled-password --gecos "" -u 1000 test
RUN echo "test ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get update && apt-get -y install curl
RUN su - test -c "curl https://sh.rustup.rs -sSf | bash -s -- -y"
RUN su - test -c ". /home/test/.cargo/env && rustup target add thumbv6m-none-eabi"

# ENV
RUN echo "export BOLOS_SDK=/opt/bolos/nanos-secure-sdk" >> ~/.bashrc

# START SCRIPT

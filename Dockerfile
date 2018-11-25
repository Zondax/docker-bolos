#Download base ubuntu image
FROM ubuntu:14.04
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

RUN pip install -U setuptools ledgerblue>=0.1.21
RUN adduser -u 1000 test

#VOLUME
RUN echo "export BOLOS_SDK=/opt/bolos/nanos-secure-sdk" >> ~/.bashrc

# ENV

# START SCRIPT

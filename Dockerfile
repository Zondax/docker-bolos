#*******************************************************************************
#    (c) 2019 ZondaX GmbH
# 
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
# 
#       http://www.apache.org/licenses/LICENSE-2.0
# 
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#*******************************************************************************
#Download base ubuntu image
FROM ubuntu:18.04
RUN apt-get update && \
    apt-get -y install build-essential git wget sudo udev zip curl cmake

RUN adduser --disabled-password --gecos "" -u 1000 test
RUN echo "test ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR /home/test

# udev rules
ADD 20-hw1.rules /etc/udev/rules.d/20-hw1.rules

RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get -y install libudev-dev libusb-1.0-0-dev && \
    apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev-i386 -y > /dev/null && \
    apt-get -y install binutils-arm-none-eabi

# ARM compilers
ADD install_compiler.sh /tmp/install_compiler.sh
RUN /tmp/install_compiler.sh

# Python
RUN apt-get update && apt-get -y install python3 python3-pip
RUN pip3 install -U setuptools ledgerblue pillow

# Rust
RUN su - test -c "curl https://sh.rustup.rs -sSf | bash -s -- -y"
RUN su - test -c ". /home/test/.cargo/env && rustup toolchain install nightly"
RUN su - test -c ". /home/test/.cargo/env && rustup target add thumbv6m-none-eabi"
RUN su - test -c ". /home/test/.cargo/env && rustup target add --toolchain nightly thumbv6m-none-eabi"

# ENV
RUN echo "export BOLOS_SDK=/opt/bolos/nanos-secure-sdk" >> /home/test/.bashrc
RUN ln -s /usr/bin/python3 /usr/bin/python

# Speculos
RUN apt-get update && apt-get -y install qemu-user-static python3-pyqt5 python3-construct python3-mnemonic python3-pyelftools gcc-arm-linux-gnueabihf libc6-dev-armhf-cross gdb-multiarch libvncserver-dev

# Use patched fork
ARG REFRESH_SPECULOS=change_to_rebuild_from_here
USER test
RUN git clone https://github.com/ZondaX/speculos.git

RUN mkdir -p /home/test/speculos/build
RUN cd /home/test/speculos && cmake -Bbuild -H.
RUN make -C /home/test/speculos/build/
EXPOSE 1234/tcp
EXPOSE 1234/udp

# START SCRIPT
ENTRYPOINT ["sh", "-c", ". /home/test/.cargo/env && \"$@\"", "-s"]

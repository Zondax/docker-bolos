#*******************************************************************************
#    (c) 2019-2021 Zondax GmbH
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
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

ARG TARGETOS TARGETARCH

RUN if [ "$TARGETARCH" = "amd64" ]; then \
    apt-get update && \
    apt-get -y install build-essential ccache golang-go git wget sudo udev zip \
    libudev-dev libusb-1.0-0-dev binutils-arm-none-eabi \
    curl cmake software-properties-common apt-utils coreutils \
    ; fi

RUN if [ "$TARGETARCH" = "arm64" ]; then \
    apt-get update && \
    apt-get -y install build-essential ccache golang-go git wget sudo zip \ 
    curl cmake software-properties-common apt-utils binutils-arm-none-eabi libncurses5 \
    ; fi

# Install Python
RUN apt-get update && apt-get -y install python3 python3-pip python-is-python3

# udev rules
ADD 20-hw1.rules /etc/udev/rules.d/20-hw1.rules
ADD install_compiler.$TARGETARCH.sh /tmp/install_compiler.sh
ADD create_users.$TARGETARCH.sh /tmp/create_users.sh
ADD install_user.sh /tmp/install_user.sh
ADD install_rust.sh /tmp/install_rust.sh

# Install Python dependencies
RUN pip3 install -U setuptools ledgerblue pillow conan

# ARM compilers
RUN /tmp/install_compiler.sh

# Create users
RUN /tmp/create_users.sh

####################################
####################################
WORKDIR /home/zondax_mac
USER zondax_mac
RUN /tmp/install_user.sh

WORKDIR /home/zondax_circle
USER zondax_circle
RUN if [ "$TARGETARCH" = "amd64" ]; then /tmp/install_user.sh; fi

WORKDIR /home/zondax
USER zondax
RUN if [ "$TARGETARCH" = "amd64" ]; then /tmp/install_user.sh; fi

# START SCRIPT
ADD entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]

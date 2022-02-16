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
#Download base ubuntu image
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install build-essential ccache git wget sudo zip \
    curl cmake software-properties-common apt-utils binutils-arm-none-eabi libncurses5

# Install Python
RUN apt-get update && apt-get -y install python3 python3-pip python-is-python3

# Install Python dependencies
RUN pip3 install -U setuptools ledgerblue pillow

# ARM compilers
ADD aarch64/install_compiler.sh /tmp/install_compiler.sh
RUN sha256sum /tmp/install_compiler.sh
RUN echo "b387ef98b84414563113bab9ae24954b5102ca50ed0c1161b51fc0f3300cf7d0 /tmp/install_compiler.sh" | sha256sum --check
RUN /tmp/install_compiler.sh

ADD install_rust.sh /tmp/install_rust.sh
ADD install_user.sh /tmp/install_user.sh

# Create zondax user
RUN adduser --disabled-password --gecos "" -u 501 zondax_mac
RUN echo "zondax_mac ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

####################################
####################################
WORKDIR /home/zondax_mac
USER zondax_mac
RUN /tmp/install_user.sh

# START SCRIPT
ADD entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]

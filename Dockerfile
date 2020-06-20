FROM ubuntu:20.10
# Update the apt package index
RUN apt-get update

# Install docker 
## install packages to allow apt to use a repository over HTTPS
RUN apt-get install -y \ 
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
## Add Docker’s official GPG key:
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
## Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below.
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
## Install the latest version of Docker Engine and containerd
RUN apt-get install docker-ce docker-ce-cli containerd.io

# Emulate raspbian image
## Install QEMU
RUN apt-get install -y \
    qemu-system

# Build Opensight image
## Install Git
RUN apt-get install -y \
    git 
## Clone opsi-gen to create raspbian image
RUN git clone git@github.com:opensight-cv/opsi-gen.git
## Run image build to opsi-gen/deploy/
RUN opsi-gen/install-docker.sh
RUN cd opsi-gen/deploy/
## unzip image
RUN unzip <image-file>.zip
RUN fdisk -l <image-file>
#mount image
RUN mkdir /mnt/raspbian


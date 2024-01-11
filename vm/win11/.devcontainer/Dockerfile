FROM ubuntu:22.04

RUN apt-get update && \
    apt-get -y install sudo
# curl
RUN sudo apt-get install curl -y
# azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# terraform
RUN apt-get update && apt-get install -y gnupg software-properties-common curl
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install terraform -y
# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    git \

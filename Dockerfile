FROM centos:6
MAINTAINER itspoma <itspoma@gmail.com>

RUN yum clean all \
 && yum install -y git curl gcc-c++ tar \
 && yum install -y mc

# node & npm
RUN curl --silent --location https://rpm.nodesource.com/setup | bash - \
 && yum install -y nodejs \
 && npm -g install npm@latest

# nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
 && . ~/.bashrc \
 && nvm install v4.4.3 \
 && nvm use v4.4.3

# meteor
RUN curl -sL https://install.meteor.com | /bin/sh

WORKDIR /shared

CMD ["/bin/bash"]

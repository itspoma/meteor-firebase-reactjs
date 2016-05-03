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

# mongo repo
ENV MONGO_REPO "/etc/yum.repos.d/mongodb.repo"

RUN echo "[mongodb]" > $MONGO_REPO \
 && echo "name=MongoDB Repository" >> $MONGO_REPO \
 && echo "baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/" >> $MONGO_REPO \
 && echo "gpgcheck=0" >> $MONGO_REPO \
 && echo "enabled=1" >> $MONGO_REPO \
 && yum clean all

# mongo
RUN yum -y install mongo-10gen mongo-10gen-server \
 && mongo --version \
 && sed 's/logappend.*/logappend=false/' -i /etc/mongod.conf \
 && echo "smallfiles=true" >> /etc/mongod.conf \
 && service mongod restart

# meteor
RUN curl -sL https://install.meteor.com | /bin/sh

WORKDIR /shared

CMD ["/bin/bash", "/shared/environment/init.sh"]

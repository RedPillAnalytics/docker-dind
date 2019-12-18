FROM docker

ENV GRADLE_USER_HOME .gradle

# Run the Update
RUN apk update
# install java
RUN apk add openjdk8
# install aws cli
RUN apk add py3-pip wget unzip bash git git-lfs openssl libc6-compat
RUN pip3 install awscli
RUN pip3 install --upgrade pip


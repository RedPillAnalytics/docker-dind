FROM docker

ENV GRADLE_USER_HOME .gradle
ENV GRADLE_VERSION 6.0.1

# Run the Update
RUN apk update
# install java
RUN apk add openjdk8
# install aws cli
RUN apk add py3-pip wget unzip bash
RUN pip3 install awscli
RUN pip3 install --upgrade pip

ENTRYPOINT ["./gradlew"]

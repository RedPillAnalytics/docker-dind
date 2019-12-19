FROM docker

ENV GRADLE_USER_HOME .gradle

# Run the Update
RUN apk update
# install java
RUN apk add openjdk8
# install aws cli
RUN apk add py3-pip wget unzip bash git git-lfs openssl libc6-compat docker-compose libstdc++ curl
RUN pip3 install --upgrade pip
RUN pip3 install awscli

#RUN gcloud components update
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

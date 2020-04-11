FROM docker

ENV GRADLE_USER_HOME=.gradle \
    GRADLE_HOME=/opt/gradle \
    GRADLE_VERSION=6.3 \
    SQLCL_ZIP=sqlcl-19.4.0.354.0937.zip \
    PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin:/sqlcl/bin

ARG GRADLE_DOWNLOAD_SHA256=038794feef1f4745c6347107b6726279d1c824f3fc634b60f86ace1e9fbd1768

# Run the Update
RUN apk update \
# install java
&& apk add openjdk8 \
# install aws cli
&& apk add py3-pip wget unzip bash git git-lfs openssl libc6-compat docker-compose libstdc++ curl ncurses coreutils \
&& pip3 install --upgrade pip \
&& pip3 install awscli \
&& curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz \
&& mkdir -p /usr/local/gcloud \
&& tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
&& /usr/local/gcloud/google-cloud-sdk/install.sh \
&& gcloud -q components update \
# SQLCL
&& curl -o $SQLCL_ZIP https://s3.amazonaws.com/software.redpillanalytics.io/oracle/sqlcl/$SQLCL_ZIP \
&& unzip $SQLCL_ZIP \
# Gradle
&& set -o errexit -o nounset \
    && echo "Downloading Gradle" \
    && wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    \
    && echo "Checking download hash" \
    && echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum --check - \
    \
    && echo "Installing Gradle" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle \
    \
    && echo "Testing Gradle installation" \
    && gradle --version

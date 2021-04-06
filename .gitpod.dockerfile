FROM gitpod/workspace-full-vnc

ENV ANDROID_HOME=/home/gitpod/android-sdk \
    FLUTTER_HOME=/home/gitpod/flutter

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    apt-get -q update && \
    apt-get -y install build-essential dart libkrb5-dev gcc make gradle android-tools-adb android-tools-fastboot openjdk-8-jdk && \
    apt-get install -yq google-chrome-stable && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*;

RUN apt clean -qq

USER gitpod

RUN cd /home/gitpod && \
    wget -c https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_2.0.3-stable.tar.xz -O flutter_sdk.tar.xz &&\
    tar -xvf flutter_sdk.tar.xz && \
    rm -f flutter_sdk.tar.xz

RUN cd /home/gitpod && \
    wget -qO android_studio.zip \
    https://dl.google.com/dl/android/studio/ide-zips/3.3.0.20/android-studio-ide-182.5199772-linux.zip && \
    unzip android_studio.zip && \
    rm -f android_studio.zip

# TODO(tianhaoz95): make the name of the SDK file into an environment variable to avoid maintainance issue
RUN mkdir -p /home/gitpod/android-sdk && \
    cd /home/gitpod/android-sdk && \
    wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip sdk-tools-linux-4333796.zip && \
    rm -f sdk-tools-linux-4333796.zip

# Change the PUB_CACHE to /workspace so dependencies are preserved.
ENV PUB_CACHE=/workspace/.pub_cache

ENV PATH "$PATH:/usr/lib/dart/bin:$FLUTTER_HOME/bin:$ANDROID_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

# add executables to PATH
RUN echo 'export PATH=${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PUB_CACHE}/bin:${FLUTTER_HOME}/.pub-cache/bin:$PATH' >>~/.bashrc

RUN chmod -R 777 ${ANDROID_HOME}

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh \
             && sdk install java 8.0.282.j9-adpt"

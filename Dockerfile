##
## Build with:
##   docker build -t xeffyr/termux-extra-packages-builder .
##
## Push to docker hub with:
##   docker push xeffyr/termux-extra-packages-builder
##

FROM ubuntu:cosmic

ENV ANDROID_SDK_REVISION "4333796"
ENV ANDROID_SDK_BUILD_TOOLS_VERSION "28.0.3"
ENV ANDROID_NDK_VERSION "18"
ENV ANDROID_HOME "/opt/termux/android-sdk"
ENV NDK "/opt/termux/android-ndk"

# We may need x86 (32bit) packages.
RUN dpkg --add-architecture i386

# Make sure that everything is up-to-date.
RUN apt update && env DEBIAN_FRONTEND=noninteractive apt upgrade -yq

# Install essential packages.
RUN env DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends \
    asciidoc asciidoctor autoconf automake bison build-essential curl devscripts \
    docbook-utils docbook-to-man ed flex g++-multilib gawk gettext git gnome-common \
    gnupg gtk-3-examples gtk-doc-tools gperf help2man intltool libexpat1-dev \
    libgdk-pixbuf2.0-dev libgmp-dev libgtk-3-bin libglib2.0-dev libisl-dev \
    libjpeg-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev \
    libssl-dev libtool-bin lzip m4 openjdk-8-jdk-headless pax-utils pkg-config \
    python-pip python3.7 python3-docutils python3-pip python3-setuptools \
    python3-sphinx ruby scons texinfo unzip valac xfonts-utils xmlto zip zlib1g-dev

# Install 32bit packages.
RUN env DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends \
    libssl-dev:i386 zlib1g-dev:i386

# Install developer tools.
RUN env DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends \
    nano silversearcher-ag patchelf patchutils

# Create user and add it to sudoers.
RUN env DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends sudo && \
    useradd -U -m builder && \
    echo "builder ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/builder

# Create necessary directories.
RUN mkdir /data && chown builder:builder /data && \
    mkdir -p /opt/termux

# Installing Android SDK and NDK.
RUN curl --fail --retry 3 -L -o sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_REVISION}.zip && \
    unzip -q sdk.zip -d ${ANDROID_HOME} && rm -f sdk.zip && \
    curl --fail --retry 3 -L -o ndk.zip https://dl.google.com/android/repository/android-ndk-r${ANDROID_NDK_VERSION}-Linux-x86_64.zip && \
    unzip -q ndk.zip && rm -f ndk.zip && mv android-ndk-r18 ${NDK}

# Installing Android SDK tools.
RUN mkdir -p /root/.android && echo 'count=0' > /root/.android/repositories.cfg
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools"
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_SDK_BUILD_TOOLS_VERSION}"
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-21"
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-27"
RUN cp -a /root/.android /home/builder/.android
RUN chown -R builder:builder /opt/termux /home/builder

# Cleanup.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory.
WORKDIR /home/builder/packages

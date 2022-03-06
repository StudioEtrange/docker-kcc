FROM ghcr.io/linuxserver/baseimage-guacgui:6be0127d-ls90


# set version label
LABEL maintainer="StudioEtrange <sboucault@gmail.com>"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV PYTHONIOENCODING=utf-8
ENV APPNAME="KCC" UMASK_SET="022"
ENV QT_DEBUG_PLUGINS 1

ENV REPO_GIT "https://github.com/ciromattia/kcc"
ENV KCC_VERSION "master"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
        python3 \
        python3-distutils \
        python3-dev \
        gcc \
    	 unzip \
        unrar \
        p7zip-full \
        # add suport for rar from 7z - solve https://github.com/ciromattia/kcc/issues/332
        p7zip-rar \
        libpng-dev \
        libjpeg-dev \
        git \
        wget \
        libxcb-xinerama0 \
        libqt5x11extras5 && \
 echo "**** install pip ****" && \
 curl -fkSL https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py && \
 python3 get-pip.py && \
 ln -s \
        /usr/bin/python3 \
        /usr/bin/python && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# RUN \
#  echo "**** install kindlegen ****" && \
#  wget -O /tmp/kindlegen.tar.gz "https://github.com/Technosoft2000/docker-calibre-web/releases/download/kindlegen/kindlegen_linux_2.6_i386_v2_9.tar.gz" && \
#  tar zxvf /tmp/kindlegen.tar.gz -C /usr/local/bin

COPY files/ /tmp
RUN \
 echo "**** install kindlegen ****" && \
 tar zxvf /tmp/kindlegen*tar.gz -C /usr/local/bin


# add local files
COPY root/ /
###############
# Build stage #
###############
FROM ubuntu:20.04 AS Builder

WORKDIR /app

RUN apt-get -y update && \
    apt-get -y upgrade

RUN apt-get -y install \
    curl \
    gcc \
    make \
    rsyslog \
    systemctl \
    unzip \
    vim

RUN /bin/bash -c "\
    curl -JLO 'https://github.com/sysstat/sysstat/archive/refs/heads/master.zip' && \
    unzip sysstat-master.zip && \
    pushd sysstat-master && \
    ./configure && \
    make && \
    make install && \
    popd && \
    rm -rf sysstat-master* \
    "

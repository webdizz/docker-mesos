FROM webdizz/baseimage-java8

MAINTAINER Izzet Mustafaiev "izzet@mustafaiev.com"

# Set correct environment variables.
ENV     HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Elasticsearch version
ENV     MESOS_VERSION 0.19.1
ENV     MESOS_URL http://downloads.mesosphere.io/master/ubuntu/14.04/mesos_${MESOS_VERSION}-1.0.ubuntu1404_amd64.deb

RUN curl -O $MESOS_URL && \
    dpkg --unpack mesos_${MESOS_VERSION}-1.0.ubuntu1404_amd64.deb && \
    apt-get install -f -y && \
    rm mesos_${MESOS_VERSION}-1.0.ubuntu1404_amd64.deb && \
    apt-get clean

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

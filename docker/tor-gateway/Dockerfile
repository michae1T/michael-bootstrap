FROM fedora

MAINTAINER michae1T@live.ca

ENV DOCKER_IMAGE_NAME michae1t/tor-gateway

RUN yum -y update

RUN yum -y install wget curl lynx telnet nc bind-utils iputils iproute net-tools traceroute
RUN yum -y install tor

ADD torrc /etc/tor/torrc
ADD sharenet.conf /etc/sysctl.d/sharenet.conf
ADD start /opt/bin/start

RUN sysctl -p

EXPOSE 53
CMD sleep 30 && /opt/bin/start


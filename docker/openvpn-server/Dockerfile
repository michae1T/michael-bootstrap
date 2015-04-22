FROM fedora

MAINTAINER michae1T@live.ca

ENV DOCKER_IMAGE_NAME michae1t/openvpn-server

RUN yum -y update

RUN yum -y install wget curl lynx telnet nc bind-utils iputils iproute net-tools traceroute
RUN yum -y install openvpn

ADD server.conf /etc/openvpn/server.conf
ADD sharenet.conf /etc/sysctl.d/sharenet.conf
ADD start /opt/bin/start

RUN sysctl -p

EXPOSE 1194
CMD sleep 30 && /opt/bin/start


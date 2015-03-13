FROM michae1t/sys:latest

MAINTAINER michae1T@live.ca

RUN cd $CONFIG_REPO   && git pull

RUN cd $BOOTSTRAP_DIR && base/yum.sh

RUN cd $BOOTSTRAP_DIR && base/bash_defaults.sh

RUN cd $BOOTSTRAP_DIR && base/common_tools.sh

RUN cd $BOOTSTRAP_DIR && docker/common_tools.sh

RUN cd $BOOTSTRAP_DIR && base/user.sh

RUN cd $BOOTSTRAP_DIR && rm -rf /opt/scala-* /opt/sbt-* \
                      && base/scala_new.sh

RUN pip3 uninstall awscli && pip3 install awscli


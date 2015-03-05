FROM fedora

MAINTAINER michae1T@live.ca

ENV DOCKER_IMAGE_NAME michaelt/sys-base

ENV SRC_DIR /root/src
ENV CONFIG_REPO $SRC_DIR/michael-system-config
ENV BOOTSTRAP_DIR $CONFIG_REPO/bootstrap

RUN yum clean all

RUN yum -y install git && yum clean all

RUN mkdir -p $SRC_DIR && cd $SRC_DIR \
    && git clone https://github.com/michae1T/michael-system-config.git

RUN cd $BOOTSTRAP_DIR && base/yum.sh

RUN cd $BOOTSTRAP_DIR && base/bash_defaults.sh

RUN cd $BOOTSTRAP_DIR && base/common_tools.sh

RUN cd $BOOTSTRAP_DIR && base/user.sh

RUN cd $BOOTSTRAP_DIR && base/scala_new.sh

RUN cd $BOOTSTRAP_DIR && base/ruby_old.sh \
                      && base/ruby_current.sh \
                      && rm -rf /root/src/ruby

RUN pip3 install awscli

RUN echo 'source /etc/bashrc' >> /root/.bashrc

CMD [ "/bin/bash" ]




FROM michae1t/sys:latest

MAINTAINER michae1T@live.ca

RUN cd $CONFIG_REPO   && git pull

RUN cd $BOOTSTRAP_DIR && rm -rf /opt/ruby-* \
                      && base/ruby_old.sh \
                      && base/ruby_current.sh \
                      && rm -rf /root/src/ruby



FROM michae1t/sys:latest

MAINTAINER michae1T@live.ca

RUN echo "random number so git pull wont be cached: $RANDOM"

RUN cd $CONFIG_REPO   && git reset --hard HEAD~1 \
                      && git pull --rebase

RUN cd $BOOTSTRAP_DIR && rm -rf /opt/ruby-* \
                      && base/ruby_old.sh \
                      && base/ruby_current.sh \
                      && rm -rf /root/src/ruby



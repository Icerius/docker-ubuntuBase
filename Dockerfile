FROM ubuntu:16.04

ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64.deb /root
RUN dpkg -i /root/dumb-init_*.deb && \
    rm /root/dumb-init_*.deb

ENTRYPOINT ["/usr/bin/dumb-init"]

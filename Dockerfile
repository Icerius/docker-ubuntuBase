FROM ubuntu:16.04

ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64.deb /root
ADD dpkg-01_nodoc /etc/dpkg/dpkg.cfg.d/01_nodoc

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No


RUN set -xe && \
    # Update packages and install required packages
    apt-get update -y && \
    #apt-get install -y --no-install-recommends software-properties-common apt-utils apt-transport-https ca-certificates && \
    apt-get dist-upgrade -y --no-install-recommends && \
    # Install dumb-init
    dpkg -i /root/dumb-init_*.deb && \
    # Cleanup 
    rm /root/dumb-init_*.deb && \
    # Cleanup APT
    apt-get clean && \
    rm -rf  /var/cache/apt/* \
            /tmp/* \
            /var/tmp/* \
            /var/lib/apt/lists/* && \
    # Cleanup unneeded doc/locale
    find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true && \
    find /usr/share/doc -empty|xargs rmdir || true && \
    rm -rf  /usr/share/man \
            /usr/share/groff \
            /usr/share/info \
            /usr/share/lintian \
            /usr/share/linda \
            /var/cache/man \
            /usr/share/locale && \
    # locale
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

    
ENTRYPOINT ["/usr/bin/dumb-init"]


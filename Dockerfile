FROM debian:jessie

LABEL \
	io.voxbox.build-date=${BUILD_DATE} \
	io.voxbox.name=fail2ban \
	io.voxbox.vendor=voxbox.io \
    maintainer=matteo@voxbox.io \
	io.voxbox.vcs-url=https://github.com/matteolc/docker-fail2ban.git \
	io.voxbox.vcs-ref=${VCS_REF} \
	io.voxbox.license=MIT

ENV APP=fail2ban
ENV HOME=/etc/${APP}

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y -q && \
    apt-get install -y -q --no-install-recommends \
        fail2ban \
        iptables \
        nullmailer \
        whois \    
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${HOME}

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh

COPY build/jail.local ${HOME}

ENTRYPOINT ["/sbin/entrypoint.sh"]
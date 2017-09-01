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
        monit \
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${HOME}

COPY runtime/ ${HOME}/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh


COPY build/jail.local ${HOME}
COPY build/${APP} /etc/monit/conf.d
COPY build/monitrc.local /etc/monit/conf.d

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
  CMD ${HOME}/healthcheck

ENTRYPOINT ["/sbin/entrypoint.sh"]

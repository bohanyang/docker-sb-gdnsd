FROM debian:buster-slim

ARG PACKAGE_VERSION="=3.2.1-1+stretch1"
ARG PACKAGE_REPO="https://mirrors.xtom.com/sb/gdnsd"

RUN set -ex; \
    buildDeps='ca-certificates gnupg'; \
    apt-get update; \
    apt-get install -y --no-install-recommends $buildDeps; \
    apt-key adv --fetch-keys "$PACKAGE_REPO/public.key"; \
    echo "deb $PACKAGE_REPO buster main" > /etc/apt/sources.list.d/sb-gdnsd.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends gdnsd$PACKAGE_VERSION; \
    apt-get purge -y --auto-remove $buildDeps; \
    rm -rf /var/lib/apt/lists/*

COPY docker-gdnsd-*.sh docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["gdnsd", "start"]

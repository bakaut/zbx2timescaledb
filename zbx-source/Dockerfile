FROM debian:stable-slim

LABEL ZABBIX_VERSION="4.0"
LABEL ZBX_INSTALL="https://www.zabbix.com/documentation/4.0/ru/manual/installation/install_from_packages/debian_ubuntu"

ENV ZBX_MAIN="4.0"
ENV ZBX_MAIN=${ZBX_MAIN}

ENV ZBX_MINOR="2"

ENV ZBX_FULL=$ZBX_MAIN-${ZBX_MINOR}

RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*
RUN wget https://repo.zabbix.com/zabbix/$ZBX_MAIN/debian/pool/main/z/zabbix-release/zabbix-release_$ZBX_FULL+stretch_all.deb
RUN dpkg -i zabbix-release_$ZBX_FULL+stretch_all.deb
RUN apt update
WORKDIR /tmp/
RUN apt-get download zabbix-server-pgsql
RUN mkdir /opt/migration
RUN dpkg -x zabbix-server-pgsql_* ./zabbix-server-pgsql

RUN cp /tmp/zabbix-server-pgsql/usr/share/doc/zabbix-server-pgsql/create.sql.gz /opt/migration/
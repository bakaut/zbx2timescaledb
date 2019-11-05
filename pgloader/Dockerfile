FROM pgloader-base

RUN mkdir /opt/migration/

COPY --from=zbx-source /opt/migration/ /opt/migration/

WORKDIR /opt/migration

RUN gzip -dc create.sql.gz > /opt/migration/schema.sql && \
    sed -n '/CREATE.*/,/INSERT.*$/p' /opt/migration/schema.sql | head -n-1 > /opt/migration/create.sql && \
    grep ALTER /opt/migration/schema.sql > /opt/migration/alter.sql && \
    grep "INSERT INTO dbversion" /opt/migration/schema.sql > /opt/migration/dbversion.sql

COPY zabbix.load  /opt/migration
COPY timescaledb.sql /opt/migration
RUN cat alter.sql >> /opt/migration/after.sql
RUN cat dbversion.sql >> /opt/migration/after.sql
RUN cat timescaledb.sql >> /opt/migration/after.sql
RUN useradd pgloader || true
RUN chown -R pgloader /opt/migration
USER pgloader
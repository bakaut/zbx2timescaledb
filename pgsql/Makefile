recreate:
	@docker kill timescaledb || true
	@docker rm timescaledb || true
	@rm -rf /opt/pgdata
	@mkdir /opt/pgdata
	@docker run --shm-size 1G -d --name timescaledb -p 5432:5432 -e TS_TUNE_MEMORY=32GB -e TS_TUNE_NUM_CPUS=8 -e TIMESCALEDB_TELEMETRY=off -e POSTGRES_DB=zabbix -e PGUSER=zabbix -e POSTGRES_PASSWORD=zabbix -v /opt/pgdata:/var/lib/postgresql/data timescale/timescaledb:latest-pg11
	@sleep 30
	@docker exec -it timescaledb psql -U postgres -c "create role zabbix with login encrypted password 'zabbix';" || true
	@docker exec -it timescaledb psql -U postgres -c "CREATE DATABASE zabbix WITH OWNER = 'zabbix' TEMPLATE = 'template0' ENCODING = 'Unicode';" || true
	@docker exec -it timescaledb psql -U postgres -c "grant all privileges on database zabbix to zabbix;" || true
	@docker rm pgfiles || true
	@docker create --name pgfiles pgloader
	@docker exec timescaledb mkdir -p /opt/migration/psql || true
	@docker cp pgfiles:/opt/migration/after.sql .
	@docker cp after.sql timescaledb:/opt/migration/after.sql
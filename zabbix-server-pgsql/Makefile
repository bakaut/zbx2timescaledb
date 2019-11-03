run:
	@docker kill zabbix-server-pgsql || true
	@docker rm zabbix-server-pgsql || true
	@docker run  -d --net=host --name zabbix-server-pgsql -e ZBX_CACHESIZE=1024M -e DB_SERVER_HOST="127.0.0.1" -e POSTGRES_USER="zabbix" -e POSTGRES_PASSWORD="zabbix"  zabbix/zabbix-server-pgsql:alpine-4.4.0
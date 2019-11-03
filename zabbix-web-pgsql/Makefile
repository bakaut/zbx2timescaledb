run:
	@docker kill some-zabbix-web-nginx-pgsql || true
	@docker rm some-zabbix-web-nginx-pgsql || true
	@docker run -d -p 80:80 --name some-zabbix-web-nginx-pgsql -e DB_SERVER_HOST="127.0.0.1"  -e POSTGRES_USER="zabbix" -e POSTGRES_PASSWORD="zabbix" -e ZBX_SERVER_HOST="127.0.0.1" -e PHP_TZ="Europe/Moscow" -d zabbix/zabbix-web-nginx-pgsql:alpine-4.4-latest
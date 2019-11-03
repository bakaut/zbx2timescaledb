build:
	@docker build  . -t  pgloader

run:

	@docker run --net=host --security-opt seccomp=unconfined pgloader pgloader --debug --client-min-messages debug  zabbix.load 
	@docker exec -it timescaledb psql -d zabbix -U zabbix -a -f /opt/migration/after.sql


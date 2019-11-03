#!/bin/bash

#backup from mysql
#mysqldump --host=127.0.0.1 --user=root --password=pass --single-transaction --events --triggers --routines --ignore-table=zabbix.history --ignore-table=zabbix.history_log --ignore-table=zabbix.history_str --ignore-table=zabbix.history_text --ignore-table=zabbix.history_uint --ignore-table=zabbix.trends --ignore-table=zabbix.trends_uint --skip-comments --quick --set-gtid-purged=OFF  zabbix | ssh root@10.10.10.10 'cat > /var/lib/mysql/backup-main-zabbix-$(date +%F_%H-%M-%S).sql'
#make pgloader bin
cd ../pgloader/builder
make build

#make zabbix source 4.0
cd ../../zbx-source
make build

#make pgloader
cd ../pgloader/
make build

#run pgsql timescale db
cd ../pgsql/
make recreate

#run pgloader migration
cd ../pgloader
make run

#make mysql to pg replication
cd ../pgmigration
make build 
make init
make run



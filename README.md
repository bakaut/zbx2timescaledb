Migration toolkit from zbx 4.0 mysql to zbx 4.4 pgsql timescaledb
----

This repo allow you check mirgation procedure without  risks

Infrastructure:
* all of zabbix components separate to different hosts
* mysql configured to master-slave replication
* test stend installed docker

All migration components  on stend (pgloader,timescaledb,zabbix server) deployed via docker

The plan:
* Make backup from mysql and deploy it to test stend
```
#Someone like this 

mysqldump --host=127.0.0.1 --user=root --password=pass --single-transaction --events --triggers --routines --ignore-table=zabbix.history --ignore-table=zabbix.history_log --ignore-table=zabbix.history_str --ignore-table=zabbix.history_text --ignore-table=zabbix.history_uint --ignore-table=zabbix.trends --ignore-table=zabbix.trends_uint --skip-comments --quick --set-gtid-purged=OFF  zabbix | ssh root@10.10.10.10 'cat > /var/lib/mysql/backup-main-zabbix-$(date +%F_%H-%M-%S).sql

mysql -uzabbix -pzabbix zabbix < /var/lib/mysql/backup-main-zabbix-2019-09-13_22-14-11.sql
```

* Build pgloader(tools for migrate), zbx-source(postgres file create.sql.gz), pg_chameleon(tools for replication mysql <-> pgsql)
* Run pgloader migration
* Run all zabbix database alter's
* Run pg_chameleon replication

```
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
```

Links:

* https://www.percona.com/blog/2018/08/17/replication-from-percona-server-for-mysql-to-postgresql-using-pg_chameleon/
* https://hatifnatt.ru/blog/2018/09/26/zabbix-mysql-to-postgresql-migration/
* https://pgloader.io/
* https://pgchameleon.org/

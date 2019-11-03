FROM python:3.6
RUN pip install pip --upgrade
RUN pip install pg_chameleon==2.0.9
RUN chameleon set_configuration_files
COPY default.yml /root/.pg_chameleon/configuration//default.yml
RUN sed -i 's/yaml.load/yaml.full_load/g' /usr/local/lib/python3.6/site-packages/pg_chameleon/lib/global_lib.py
COPY init.sh /root/
#RUN chameleon create_replica_schema --debug
#RUN chameleon add_source --config default --source mysql --debug
#RUN chameleon init_replica --config default --source mysql --debug

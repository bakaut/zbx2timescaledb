build:
	@docker build . -t chameleon

config:
	@docker run -d --net=host  --shm-size 1G chameleon /root/init.sh
	
run:
	@docker run -d --net=host  --shm-size 1G chameleon chameleon start_replica --config default --source mysql --debug

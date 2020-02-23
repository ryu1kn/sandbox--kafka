kafka_dir := kafka-docker

kafka_instance = $(shell docker ps --filter name=kafka-docker_kafka -q)
run_remote = docker exec -it $(call kafka_instance) bash -c '$1'

.PHONY: run-remote
run-remote:
	$(if $c,,$(error Specify command with `c` (e.g. c='echo hi')))
	$(call run_remote,$c)

.PHONY: remote
remote:
	$(call run_remote,bash)

.PHONY: kafka-% connect-% zookeeper-%
kafka-% connect-% zookeeper-%:
	$(if $(params),,$(info [INFO] Use `params` to pass parameters if necessary (e.g. params=--version)))
	$(call run_remote,$$KAFKA_HOME/bin/$@.sh $(params))

.PHONY: kafka.up
kafka.up: $(kafka_dir)
	cd $< && docker-compose up

.PHONY: kafka.down
kafka.down: $(kafka_dir)
	cd $< && docker-compose down

$(kafka_dir):
	git clone https://github.com/wurstmeister/kafka-docker $@
	sed -i.bkp 's/\bKAFKA_ADVERTISED_HOST_NAME:.*/HOSTNAME_COMMAND: "route -n | awk '"'"'\/UG[ \\t]\/ {print $$$$2}'"'"'"/' $(kafka_dir)/docker-compose.yml

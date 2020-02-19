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

.PHONY: kafka
kafka:
	$(if $s,,$(error Specify sub-command with `s` (e.g. s=topics)))
	$(if $p,,$(info [INFO] Use `p` to pass parameters if necessary (e.g. p=--version)))
	$(call run_remote,$$KAFKA_HOME/bin/kafka-$s.sh $p)

.PHONY: kafka-up
kafka-up: $(kafka_dir)
	cd $< && docker-compose up -d

.PHONY: kafka-down
kafka-down: $(kafka_dir)
	cd $< && docker-compose stop

$(kafka_dir):
	git clone https://github.com/wurstmeister/kafka-docker $@

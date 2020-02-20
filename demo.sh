#!/bin/bash

set -euo pipefail

make kafka.topics params='--list --bootstrap-server localhost:9092'
make kafka.topics params='--bootstrap-server localhost:9092 --create --topic our-chat --partitions 1 --replication-factor 1'
make kafka.topics params='--bootstrap-server localhost:9092 --list'
make kafka.topics params='--bootstrap-server localhost:9092 --topic our-chat --describe'
make kafka.console-producer params='--topic our-chat --broker-list localhost:9092'
make kafka.console-consumer params='--bootstrap-server localhost:9092 --topic our-chat --from-beginning'

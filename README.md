
# Kafka Sandbox

## Usage

Bring up Kafka with docker-compose

```sh
make kafka-up
```

Use `kafka-topics` command

```sh
make kafka s=topics p=--help
```

Jump to kafka instance

```
make remote
```

For more details, see [Makefile](./Makefile).

* [kafka-docker](https://github.com/wurstmeister/kafka-docker)
* [Apache Kafka CLI commands cheat sheet](https://medium.com/@TimvanBaarsen/apache-kafka-cli-commands-cheat-sheet-a6f06eac01b)
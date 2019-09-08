# Kafka Producer

## Introduction

Apache Kafka Producers write data to `topics` made up of `partitions`. Kafka Producers automatically know which `broker` and partition to write to. Producer writes are load-balanced across brokers. Producers can send messages with a specified `key` to ensure that messages go to the same partition in order to guarantee ordering. Producers can also request acknowledgement from the `leader` or in-sync replicas (`ISRs`).

## Local Build

Perform the following:
1. Install [kafka-python](https://github.com/dpkp/kafka-python) and all dependencies: `./setup_producer.sh`
2. Start the producer: `./producer.py <stock symbol> localhost:9092 <API key>`
3. Start the consumer: `./consumer.py <stock symbol> localhost:9092`
Note: The consumer is not part of the tech stack. It is used here to ensure the producer is writing the raw data correctly.
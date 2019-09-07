# Kafka Producer

## Introduction

Apache Kafka Producers write data to `topics` made up of `partitions`. Kafka Producers automatically know which `broker` and partition to write to. Producer writes are load-balanced across brokers. Producers can send messages with a specified `key` to ensure that messages go to the same partition in order to guarantee ordering. Producers can also request acknowledgement from the `leader` or in-sync replicas (`ISRs`).

## Local Build

Perform the following:
1. Install [kafka-python](https://github.com/dpkp/kafka-python) and all dependencies: `./setup_producer.sh`
2. Start the producer: `./producer.py`
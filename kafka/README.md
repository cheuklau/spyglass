# Kafka

## Introduction

Apache Kafka decouples data streams and systems. It is designed to be distributed, resilient and fault-tolerant. A `topic` is a particular stream of data. Topics are split into `partitions`, and each message within a partition gets an ID called an `offset`. Messages are kept for a given retention period. Kafka distributes partitions across different machines i.e., `brokers`. Topics should have a `replication factor` greater than one. Each partition has one `leader` and multiple in-sync replicas (`ISRs`). Only the `leader` can receive and serve data for a partition while the ISRs synchronize the data. Zookeeper performs `leader election` and ISRs.

## Local Build

To download and setup Kafka binaries run `build_local.sh`.

To start a local Kafka server (and Zookeeper) run `start_kafka.sh`.




#!/bin/bash

# Create data directories for Zookeeper and Kafka
mkdir -p kafka_2.12-1.0.1/data/zookeeper
mkdir -p kafka_2.12-1.0.1/data/kafka

# Update Zookeeper config with new data directory
sed 's/dataDir/dataDir="$(PWD)/kafka_2.12-1.0.1/data/zookeeper"' kafka_2.12-1.0.1/config/zookeeper.properties

# Start Zookeeper
zookeeper-server-start.sh kafka_2.12-1.0.1/config/zookeeper.properties

# Update Kafka server properties with new data directory
sed 's/log.dirs/log.dirs="$(PWD)/kafka_2.12-1.0.1/data/kafka"' kafka_2.12-1.0.1/config/server.properties

# Start Kafka
kafka-server-start.sh kafka_2.12-1.0.1/config/server.properties

echo "INFO: Local Zookeeper and Kafka has been started"
exit(0)

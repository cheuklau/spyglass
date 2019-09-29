#!/bin/bash

# Stop Kafka
kafka-server-stop.sh
if [[ $? -gt 0 ]]; then
  echo "WARN: Unable to stop Kafka"
fi

# Stop Zookeeper
zookeeper-server-stop.sh
if [[ $? -gt 0 ]]; then
  echo "WARN: Unable to stop Zookeeper"
fi 

# Remove Zookeeper and Kafka data directories
rm -rf kafka_2.12-2.0.0/data/zookeeper
rm -rf kafka_2.12-2.0.0/data/kafka

# Remove output and error files
rm *.out *.err

exit 0
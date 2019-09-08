#!/bin/bash

# Stop Kafka
kafka-server-stop.sh
if [[ $? -gt 0 ]]; then
  echo "Unable to stop Kafka"
  exit 1
fi 

# Stop Zookeeper
zookeeper-server-stop.sh
if [[ $? -gt 0 ]]; then
  echo "Unable to stop Zookeeper"
  exit 1
fi 

# Remove Zookeeper and Kafka data directories
rm -rf kafka_2.12-2.0.0/data/zookeeper
rm -rf kafka_2.12-2.0.0/data/kafka

exit 0
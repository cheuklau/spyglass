#!/bin/bash

# Create data directories for Zookeeper and Kafka
mkdir -p kafka_2.12-2.0.0/data/zookeeper
mkdir -p kafka_2.12-2.0.0/data/kafka

# Update Zookeeper config with new data directory
sed -i '' "s/dataDir.*/dataDir=${PWD//\//\\/}\/kafka_2.12-2.0.0\/data\/zookeeper/" kafka_2.12-2.0.0/config/zookeeper.properties

# Start Zookeeper
nohup zookeeper-server-start.sh kafka_2.12-2.0.0/config/zookeeper.properties > zookeeper.out 2> zookeeper.err &

# Update Kafka server properties with new data directory
sed -i '' "s/log.dirs.*/log.dirs=${PWD//\//\\/}\/kafka_2.12-2.0.0\/data\/kafka/" kafka_2.12-2.0.0/config/server.properties

# Start Kafka
nohup kafka-server-start.sh kafka_2.12-2.0.0/config/server.properties > kafka.out 2> kafka.err &

# Ensure Kafka and Zookeeper are running
# Here we are using nc to establish a tcp connection with port 2181 where Zookeeper is running.
# Then we are running Zookeeper's dump command which shows all of the open nodes
# created by Kafka brokers.
sleep 30
if [[ $(echo dump | nc localhost 2181 | grep brokers) ]]; then
  echo "Local Zookeeper and Kafka has been started"
  exit 0
else
  echo "Local Zookeeper and Kafka failed to start"
  exit 1
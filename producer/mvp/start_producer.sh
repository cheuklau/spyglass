#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: ./producer.py <stock symbol> <kafka address> <api key>"
  exit 1
fi

# Parse arguments
stock=$1
address=$2
apikey=$3

# Start producer
nohup ./producer.py $stock $address $apikey > producer.out 2> producer.err &

# Wait a little bit for producer to create topic and start sending messages to Kafka
sleep 10

# Start consumer
nohup ./consumer.py $stock $address > consumer.out 2> consumer.err &

# Wait a little bit for consumer to read a few messages
sleep 10

# Verify that messages are being consumed
if [[ ! $(cat consumer.out | grep ConsumerRecord) ]]; then
  echo "Data is not going to the consumer"
  exit 1
else
  echo "Successfully started producer and consumer"
  exit 0
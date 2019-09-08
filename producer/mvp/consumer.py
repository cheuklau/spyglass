#!/usr/bin/python

from kafka import KafkaConsumer
import json
import time
import sys

def create_consumer(topic, server):
    """Create Kafka consumer

    Deserialization converts a stream of bytes into an object.
    We need to create a consumer that can deserialize Kafka streams back into json.

    """

    consumer = KafkaConsumer(topic, 
                            auto_offset_reset='earliest',
                            enable_auto_commit=True,
                            auto_commit_interval_ms=5000,
                            group_id='test',
                            value_deserializer=lambda v: json.loads(v.decode('utf-8')),
                            bootstrap_servers=server)

    return consumer


if __name__ == "__main__":

    if len(sys.argv) < 2:
        exit("Usage: ./consumer.py <stock symbol> <kafka broker address>")
    stock = sys.argv[1]
    server = sys.argv[2]

    consumer = create_consumer('test-topic-'+stock, server)

    for message in consumer:

        print message
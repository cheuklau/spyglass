#!/usr/bin/python

from kafka import KafkaConsumer
import json
import time

def create_consumer(topic, server):
    """Create Kafka consumer

    Deserialization converts a stream of bytes into an object.
    We need to create a consumer that can deserialize Kafka streams back into json.

    """

    consumer = KafkaConsumer(topic, value_deserializer=lambda v: json.loads(v.decode('utf-8')),
                            bootstrap_servers=server)

    return consumer


if __name__ == "__main__":

    if len(sys.argv) < 2:
        exit("Usage: ./consumer.py <stock symbol> <kafka broker address>")
    stock = sys.argv[1]
    server = sys.argv[2]

    consumer = create_consumer(server)

    for message in consumer:

        print message
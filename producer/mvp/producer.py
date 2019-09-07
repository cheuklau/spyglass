#!/usr/bin/python

from kafka import KafkaProducer
import json

def create_producer(server):
    """Create Kafka producer

    Serialization converts an object into a stream of bytes used for transmission.
    We need to create a producer that can serialize json messages returned from 
    the Alpha Vantage API.

    """

    producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                            bootstrap_servers=server)

    return producer


if __name__ == "__main__":

    if len(sys.argv) < 3:
        exit("Usage: ./producer.py <stock symbol> <kafka broker address> <API key>")
    stock = sys.argv[1]
    server = sys.argv[2]
    apikey = sys.argv[3]

    producer = create_producer(server)

    # First populate last 100 data points of intraday trade

    # Next populate only most recent data point of intraday trade
    # If this is run in off-hours then data point will be unchanged
    while True:

        # Poll the API to get a response


        # Send to Kafka
        producer.send()
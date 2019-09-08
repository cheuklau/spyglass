#!/usr/bin/python

from kafka import KafkaProducer
import json
import urllib
import time

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
    # The returned result is of this form:
    # {
    # "Meta Data": {
    #     "1. Information": "Intraday (5min) open, high, low, close prices and volume",
    #     "2. Symbol": "MSFT",
    #     "3. Last Refreshed": "2019-09-06 16:00:00",
    #     "4. Interval": "5min",
    #     "5. Output Size": "Compact size",
    #     "6. Time Zone": "US/Eastern"
    # },
    # "Time Series (5min)": {
    #     "2019-09-06 16:00:00": {
    #         "1. open": "139.1100",
    #         "2. high": "139.2400",
    #         "3. low": "138.9900",
    #         "4. close": "139.1300",
    #         "5. volume": "1142652"
    #     },
    #     ...
    url = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=%s&interval=5min&outputsize=compact&apikey=%s' % (stock, apikey)
    data = json.load(urllib.urlopen(url))["Time Series (5min)"]

    for timestamp in data:

        # Add the timestamp to the message
        data[timestamp]['timestamp'] = timestamp

        # Send the message
        producer.send('test-topic-'+stock, data[timestamp])

    # Next populate only most recent data point of intraday trade
    # If this is run in off-hours then data point will be unchanged
    while True:

        # Poll the API to get a response
        data = json.load(urllib.urlopen(url))["Time Series (5min)"]

        # Return the first timestamp
        timestamp = next(iter(data))

        # Add the timestamp to the message
        data[timestamp]['timestamp'] = timestamp

        # Send the message
        producer.send('test-topic-'+stock, data[timestamp])

        # Wait 30 seconds
        time.sleep(30)
#!/usr/bin/python3

from kafka import KafkaProducer
import faust
import math

class StockData(faust.Record, serializer='json'):
    open_price: float
    high_price: float
    low_price: float
    close_price: float
    volume: int
    date: string

def create_faust_app(server):
    """ Create the Faust app
    """

    # Default serialization is JSON
    return faust.App('mvp', broker='kafka://'+server)


if __name__ == "__main__":

    if len(sys.argv) < 2:
        exit("Usage: ./producer.py <stock symbol> <kafka broker address>")
    stock = sys.argv[1]
    server = sys.argv[2]

    # Define Kafka producer
    producer = KafkaProducer(bootstrap_servers=server)

    # Create Faust app
    app = create_app(server)

    # Define Faust topic
    topic = app.topic('test-topic-'+stock, value_type=StockData)

    # Define table to store cumulative sum of intraday volatility
    # Default value for missing key will be 0.0 with default option
    volatility = app.Table('parkinson', default=list)

    # Parkinson fixed factor
    # Note: we use N = 5 since we calculate with 5-minute window in 1-minute increments
    parkinson_factor = 1.0 / (20.0 * math.log(2.0))

    # Data is provided every minute so we can calculate Parkinson volatility on a rolling
    # 5-minute window
    @app.agent(topic)
    async def parkinson(events):
        async for event in events:

            # Store Parkinson summation contribution for current period
            volatility[stock].append(math.log(event.high_price/event.low_price))

            # Calculate 5-minute window Parkinson volatility
            sigma = math.sqrt(parkinson_factor*sum(volatility[stock][-5])**2.0)

            # Send to Kafka
            producer.send('parkinson-'+stock, sigma)
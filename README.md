# SPYglass: Batch and Real-time Financial Data Pipelines

## Introduction

## Tech Stack

### Data Source

We use [Alpha Vantage](https://www.alphavantage.co) which provides APIs for accessing both historical and real-time financial data. Alpha Vantage APIs are grouped into four categories:
1. Stock time-series data,
2. Physical and crypto currencies,
3. Technical indicators, and
4. Sector performances.

All APIs are in real-time with the latest data points derived from the current trading day. The initial focus will be on stock time-series data.

### Data Ingestion

We create custom [Kafka Producers](https://kafka.apache.org/10/javadoc/org/apache/kafka/clients/producer/KafkaProducer.html) that query from the Alpha Advantage API and store the raw data into Kafka. There are two types of producers:
1. Historical producers pull daily, weekly and monthly data (up to 20 years worth), and
2. Real-time producers pull current intraday data.

### Data Processing

We will use [Faust](https://github.com/robinhood/faust) to perform streaming and event processing to calculate on-the-fly metrics e.g., [intraday volatility measures](https://eranraviv.com/intraday-volatility-measures/).

### Real-Time Analytics

We will use [Druid](https://druid.apache.org/docs/latest/tutorials/index.html) to index data from Kafka. This will allow us to perform real-time querying and display real-time dashboards.

### Future Work: Batch Processing

Kafka Connect will be used to write historical data into HDFS. Airflow will run daily, weekly and monthly jobs to calculate aggregate metrics.

### Future Work: Historical Analytics

Aggregate metrics will be stored in Postgres and read from a dashboard.

## Local Build (MVP)

A demonstration minimum viable product (MVP) can be set up on your local desktop:

1. Obtain an Alpha Vantage API key
2. Set up and start local Kafka and Zookeeper servers:
```
cd /path/to/kafka/mvp
./setup_kafka.sh
./start_kafka.sh
```
3. Set up and start local Kafka producer:
```
cd /path/to/producer/mvp
./setup_producer.sh
./start_producer.sh <stock symbol> localhost:9092 <api key>
```
Note: This starts up a consumer (not part of the tech stack) to verify messages are being produced and consumed. Messages consumed can be viewed in `consumer.out`.

4. Setup and start local Faust processors (TBD)
5. Setup and Start local Druid server (TBD)
6. Shutdown mvp:
```
cd /path/to/producer/mvp
./stop_producer.sh
cd /path/to/kafka/mvp
./stop_kafka.sh
```
Note: The above scripts will clear the Kafka and Zookeeper data directories and Kafka producer and consumer output and logs.
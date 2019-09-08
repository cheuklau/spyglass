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
2. Set up and statrt local Kafka and Zookeeper servers:
```
./kafka/mvp/setup_kafka.sh
./kafka/mvp/start_kafka.sh
```
3. Set up and start local Kafka producers:
```
./producer/mvp/setup_producer.sh
./producer/mvp/producer.py <stock symbol> localhost:9092 <API key>
```
4. Setup and start local Faust processors (TBD)
5. Setup and Start local Druid server (TBD)
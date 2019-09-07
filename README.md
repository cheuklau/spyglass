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

We create custom Kafka Producers that query from Alpha Advantage API and store the raw data into Kafka. There are two types of producers:
1. Historical producers pull all available daily, weekly and monthly historical stock data (up to 20 years worth), and
2. Real-time producers pull real-time intraday stock data.

### Data Processing

We will use Kafka Streams to clean and enrich the data. 

### Real-Time Analytics

We will use Druid to hold real-time data to perform streaming analytics. This will feed real-time dashboards.

### Future Work: Batch Processing

Kafka Connect will be used to write historical data into HDFS. Airflow will run daily, weekly and monthly jobs to calculate aggregate metrics.

### Future Work: Historical Analytics

Aggregate metrics will be stored in Postgres and read from a dashboard.

## Local Build (MVP)

A demonstration minimum viable product (MVP) can be set up on your local desktop:
1. Set up local Kafka and Zookeeper servers:
```
cd kafka
./build_local.sh
./start_kafka.sh
```
2. Start the test producers (TBD)
3. Start the test transformers (TBD)
4. Start local Druid server (TBD)
5. Start the dashboard (TBD)
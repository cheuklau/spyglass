# Spyglass: Batch and Real-time Financial Data Pipelines

## Section 1 - Introduction

## Section 2 - Data Engineering Tech Stack

### Section 2.1 - Data Source

We use [Alpha Vantage](https://www.alphavantage.co) which provides APIs for accessing both historical and real-time financial data. Alpha Vantage APIs are grouped into four categories:
1. Stock time-series data,
2. Physical and crypto currencies,
3. Technical indicators, and
4. Sector performances.

All APIs are in real-time with the latest data points derived from the current trading day.

### Section 2.2 - Data Ingestion

We create custom [Kafka Producers](https://kafka.apache.org/10/javadoc/org/apache/kafka/clients/producer/KafkaProducer.html) that pull real-time financial data from the Alpha Advantage API and store the results in Kafka.

### Section 2.3 - Data Processing

We will use [Faust](https://github.com/robinhood/faust) to perform streaming and event processing to calculate on-the-fly metrics e.g., [intraday volatility measures](https://eranraviv.com/intraday-volatility-measures/).

### Section 2.4 - Real-Time Analytics

We will use [Druid](https://druid.apache.org/docs/latest/tutorials/index.html) to index data from Kafka. This will allow us to perform real-time querying and display real-time dashboards.

### Section 2.5 - Future Work

#### Section 2.5.1 Batch Processing

Kafka Connect will write historical data into HDFS. Airflow will run daily, weekly and monthly jobs to calculate aggregate metrics. Apply machine learning methods to generate models that can be used in real-time analytics to gain insight into real-time financial data.

## Section 3 - Local Minimum Viable Product (MVP)

Perform the following steps to set up the local MVP:
1. Obtain an Alpha Vantage API key
2. Set up Kafka and Zookeeper:
```
cd $HOME/src/kafka/mvp
./setup_kafka.sh
```
3. Start Kafka and Zookeeper:
```
./start_kafka.sh
```
4. Set up Kafka producer:
```
cd $HOME/src/producer/mvp
./setup_producer.sh
```
5. Start the Kafka prodcuer:
```
./start_producer.sh <stock symbol> localhost:9092 <api key>
```
This also starts up a Kafka Consumer to verify messages are being produced. Messages consumed can be viewed in `consumer.out`.

6. Setup and start local Faust processors (TBD)
7. Setup and start local Druid server (TBD)
8. Shutdown mvp:
```
$HOME/src/producer/mvp/stop_producer.sh
$HOME/src/kafka/mvp/stop_kafka.sh
```

## Section 4 - Production DevOps Tech Stack

### Section 4.1 - Kops

- Use kops to create Kubernetes cluster on AWS
- Write output as Terraform for version control

### Section 4.2 - Docker

- Dockerize each component of pipeline

### Section 4.3 - Helm

- Write each application as a Helm deployment

### Section 4.4 - Prometheus

- Add Prometheus operator to cluster to monitor Kubernetes cluster

### Section 4.5 - Elastic Stack

- Add Elastic Stack to monitor application logs
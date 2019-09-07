# Kafka Stream

## Introduction

Kafka Stream leverages `consumer` and `producer` APIs when communicating with Kafka. We discussed about producers [here](insert link). Consumers read messages from a topic. Messages are read in order within each partition. Consumers read data in consumer `groups`. Each consumer within a group reads from exclusive partitions. Kafka stores the `offsets` at which a consumer group last read in a topic named `_consumer_offsets`. If a consumer restarts, it will begin at the offset it left off. 
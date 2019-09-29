#!/bin/bash

# Download Kafka 2.12-2.0.0 binaries
wget https://archive.apache.org/dist/kafka/2.0.0/kafka_2.12-2.0.0.tgz

# Unpack
tar -xvf kafka_2.12-2.0.0.tgz

# Check Java version
if [[ ! $(java -version 2>&1 | grep -o '"1.8.*"') ]]; then
  echo "ERROR: Kafka requires Java 8"
  exit 1
fi

# Clean up zip file
rm kafka_2.12-2.0.0.tgz

# Add downloaded binaries to path
echo "export PATH=$(PWD)/kafka_2.12-2.0.0/bin:"'${PATH}' >> ~/.bash_profile
source ~/.bash_profile

echo "INFO: Local Kafka has been installed"
exit 0
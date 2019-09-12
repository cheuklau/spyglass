#!/bin/bash

# Ensure Python3 is available
if [[ ! $(which python3) ]]; then
  echo "Python 3.6+ is required to run Faust"
  exit 1
fi

# Install faust
sudo python3 -m pip install faust

if [[ $? -gt 0 ]]; then
  echo "Successfully installed kafka-python"
  exit 0
else
  echo "Failed to install Faust"
  exit 1
fi
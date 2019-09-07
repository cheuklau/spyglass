#!/bin/bash

# Ensure pip is installed
if [[ ! $(which pip) ]]; then
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  sudo python get-pip.py 
  rm get-pip.py 
fi

# Ensure kafka-python is installed
if [[ ! $(pip list | grep kafka-python) ]]; then
  sudo python -m pip install --upgrade pip setuptools wheel
  sudo pip install kafka-python
fi

echo "INFO: Successfully installed kafka-python"
exit(0)
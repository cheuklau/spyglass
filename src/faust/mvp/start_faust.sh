#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: ./faust_parkinson.py <stock symbol> <kafka address>"
  exit 1
fi

# Parse arguments
stock=$1
address=$2

# Start Faust
nohup ./faust_parkinson.py $stock $address > faust.out 2> faust.err &
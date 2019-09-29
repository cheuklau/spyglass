#!/bin/bash

# Stop producer
ps aux | grep [p]roducer | awk '{print $2}' | xargs kill
if [[ $? -gt 0 ]]; then
  echo "Failed to stop producer"
fi

sleep 10

# Stop consumer
ps aux | grep [c]onsumer | awk '{print $2}' | xargs kill
if [[ $? -gt 0 ]]; then
  echo "Failed to stop consumer"
fi

# Remove error and output files
rm *.err *.out 

exit 0
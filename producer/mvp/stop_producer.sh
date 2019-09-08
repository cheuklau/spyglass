#!/bin/bash

# Stop producer
ps aux | grep [p]roducer | awk '{print $2}' | xargs kill
if [[ $? -gt 0 ]]; then
  echo "Failed to stop producer"
fi

# Stop consumer
ps aux | grep [c]onsumer | awk '{print $2}' | xargs kill
if [[ $? -gt 0 ]]; then
  echo "Failed to stop consumer"
fi

exit 0
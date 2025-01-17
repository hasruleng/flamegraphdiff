#!/bin/bash

# Check if the input file argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <input_file>"
    echo "For example: $0 <input_file>"
    exit 1
fi

input_file=$1
log_file="./logs/monitor_changes.log"
echo "Monitoring $input_file for changes..." > $log_file

while inotifywait -e modify $input_file; do
    echo "$(date): Detected modification in $input_file" >> $log_file
    echo "Current working directory: $(pwd)"
    ./autoupdate/generate_flamegraph.sh $input_file >> $log_file 2>&1
    if [ $? -eq 0 ]; then
        echo "$(date): Successfully executed generate_flamegraph.sh" >> $log_file
    else
        echo "$(date): Failed to execute generate_flamegraph.sh" >> $log_file
    fi
    echo "$(date): Flame graph generated for $input_file" >> $log_file
done
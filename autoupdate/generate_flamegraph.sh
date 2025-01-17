#!/bin/bash
input_file=$1
output_file="${input_file%.*}.svg"  # Remove the file extension and add .svg
log_file="./logs/generate_flamegraph.log"

# Debugging statements
echo "$(date): Current working directory: $(pwd)" | tee -a $log_file

echo "$(date): Starting flame graph generation" >> $log_file
echo "Input file: $input_file" >> $log_file
echo "Output file: $output_file" >> $log_file

# Run flamegraph.pl and capture any errors
./FlameGraph/flamegraph.pl $input_file > $output_file 2>> $log_file

# Check if the output file was created
if [ -f "$output_file" ]; then
    echo "$(date): Flame graph generated successfully: $output_file" >> $log_file
else
    echo "$(date): Failed to generate flame graph" >> $log_file
fi
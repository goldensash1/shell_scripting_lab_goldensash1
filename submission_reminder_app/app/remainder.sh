#!/bin/bash
# Script that reminds students of upcoming deadlines

source ../config/config.env
source ../modules/functions.sh

echo "Checking for upcoming deadlines..."

cat ../assets/submission.txt | while read -r line; do
    echo "Reminder: $line"
done

#!/bin/bash

function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}

function list_students {
    local submissions_file=$1
    echo "Listing students and their submission status for $ASSIGNMENT"

    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        echo "$student has $status the $ASSIGNMENT assignment."
    done < <(tail -n +2 "$submissions_file")
}

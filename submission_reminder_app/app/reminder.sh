#!/bin/bash

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

# Loop to allow choosing different operations
while true; do
    echo "Choose an option:"
    echo "1. Check for unsubmitted assignments"
    echo "2. List all students and their submission status"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            check_submissions $submissions_file
            ;;
        2)
            list_students $submissions_file
            ;;
        3)
            echo "Exiting application."
            break
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done

#!/bin/bash

function send_reminder() {
    local student_name=$1
    local assignment=$2
    local due_date=$3
    echo "Reminder for $student_name: Assignment '$assignment' is due on $due_date."
}


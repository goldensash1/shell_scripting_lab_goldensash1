#!/bin/bash

# Create app directories
mkdir -p submission_reminder_app
mkdir -p submission_reminder_app/assets
mkdir -p submission_reminder_app/config
mkdir -p submission_reminder_app/modules
mkdir -p submission_reminder_app/app

# Create submissions data
cat <<EOL > submission_reminder_app/assets/submissions.txt
student, assignment, submission status
here, Shell Navigation, submitted
Noel, Shell Navigation, not submitted
Goldens, Shell Navigation, submitted
Ngwoke, Shell Navigation, not submitted
Uche, Shell Navigation, submitted
Victor, Shell Navigation, not submitted
Salomon, Shell Navigation, submitted
EOL

# Configuration file
cat <<EOL > submission_reminder_app/config/config.env
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# Functions file
cat <<EOL > submission_reminder_app/modules/functions.sh
#!/bin/bash

function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"

    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}

function list_students {
    local submissions_file=\$1
    echo "Listing students and their submission status for \$ASSIGNMENT"

    while IFS=, read -r student assignment status; do
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        echo "\$student has \$status the \$ASSIGNMENT assignment."
    done < <(tail -n +2 "\$submissions_file")
}
EOL

# Main reminder script
cat <<EOL > submission_reminder_app/app/reminder.sh
#!/bin/bash

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

# Loop to allow choosing different operations
while true; do
    echo "Choose an option:"
    echo "1. Check for unsubmitted assignments"
    echo "2. List all students and their submission status"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    case \$choice in
        1)
            check_submissions \$submissions_file
            ;;
        2)
            list_students \$submissions_file
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
EOL

# Startup script
cat <<EOL > submission_reminder_app/startup.sh
#!/bin/bash

echo "Starting the submission reminder application..."

./app/reminder.sh
EOL

# Make scripts executable
chmod +x submission_reminder_app/app/reminder.sh
chmod +x submission_reminder_app/startup.sh
chmod +x submission_reminder_app/modules/functions.sh

echo "Environment setup complete!"


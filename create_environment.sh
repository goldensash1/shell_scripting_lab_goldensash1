#!/bin/bash

# Create the main application directory
app_dir="submission_reminder_app"
mkdir -p "$app_dir"

# Declare an associative array to store directories and files
declare -A directories=(
    ["app"]="reminder.sh"
    ["modules"]="functions.sh"
    ["assets"]="submission.txt"
    ["config"]="config.env"
)

# Loop through the directories and create them, along with their respective files
for dir in "${!directories[@]}"; do
    mkdir -p "$app_dir/$dir"
    file="${directories[$dir]}"
    touch "$app_dir/$dir/$file"
done

# Create the startup.sh file outside of the directories listed above
touch "$app_dir/startup.sh"

# Populate the necessary files with initial content
echo "#!/bin/bash" > "$app_dir/app/reminder.sh"
echo "#!/bin/bash" > "$app_dir/modules/functions.sh"
echo "# Configuration File" > "$app_dir/config/config.env"

# Populate the submission.txt file with existing data from submissions.txt (assuming submissions.txt is in the same directory)
if [ -f "submissions.txt" ]; then
    cat submissions.txt > "$app_dir/assets/submission.txt"
else
    echo "submissions.txt not found. Creating an empty submission.txt"
    touch "$app_dir/assets/submission.txt"
fi

# Add 5 additional student records to submission.txt
for i in {4..8}; do
    echo "Student$i, Assignment$i, Due: 2024-10-0$i" >> "$app_dir/assets/submission.txt"
done

# Make the scripts executable
for file in "app/reminder.sh" "modules/functions.sh" "startup.sh"; do
    chmod +x "$app_dir/$file"
done

echo "Environment setup is complete."


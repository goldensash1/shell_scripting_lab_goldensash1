#!/bin/bash
# Startup

echo "Starting the $APP_NAME (version $VERSION)..."

#Config files
source ./config/config.env
source ./modules/functions.sh

./app/reminder.sh


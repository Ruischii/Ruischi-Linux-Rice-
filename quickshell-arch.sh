#!/bin/bash

# This script outputs the current date and time in UTC format
# and the current user's login name.

# Get the current date and time in UTC format
current_date_time=$(date -u '+%Y-%m-%d %H:%M:%S')

# Get the current user's login name
current_user=$(whoami)

# Output the results
echo "Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): $current_date_time"
echo "Current User's Login: $current_user"
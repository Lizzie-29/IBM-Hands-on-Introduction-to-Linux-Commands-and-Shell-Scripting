#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory="$1"         # Set targetDirectory to the first command line argument
destinationDirectory="$2"    # Set destinationDirectory to the second command line argument

# [TASK 2]
echo "Target Directory: $1"          # Display the first command line argument
echo "Destination Directory: $2"      # Display the second command line argument

# [TASK 3]
currentTS=$(date +%s)  # This sets currentTS to the current time in seconds since epoch

# [TASK 4]
backupFileName="backup-[$currentTS].tar.gz"  # This uses the current timestamp variable

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)  # This sets origAbsPath to the current directory's absolute path

# [TASK 6]
cd "$destinationDirectory" || { echo "Failed to change to destination directory"; exit 1; }
# Define a variable for the destination absolute path
destAbsPath=$(pwd)  # This sets destAbsPath to the absolute path of the destination directory

# [TASK 7]
cd "$origAbsPath" || { echo "Failed to change to original directory"; exit 1; }
# Then change to the target directory
cd "$targetDirectory" || { echo "Failed to change to target directory"; exit 1; }

# [TASK 8]
yesterdayTS=$(($currentTS - 24 * 60 * 60))  # This calculates the timestamp for 24 hours prior

declare -a toBackup


for file in $(ls);  # [TASK 9]

do
  # [TASK 10]
  file_last_modified_date=$(date -r "$file" +%s)  # Get last modified date in seconds
  
  # Check if the file was modified within the last 24 hours
  if [[ $file_last_modified_date -gt $yesterdayTS ]]; then
    # [TASK 11]
   toBackup+=("$file")  # Add the updated file to the array
  fi
done

# [TASK 12]
# After the for loop, compress and archive the files
tar -czvf "$backupFileName" "${toBackup[@]}"

# [TASK 13]
# Move the backup file to the destination directory
mv "$backupFileName" "$destAbsPath"

# Congratulations! You completed the final project for this course!

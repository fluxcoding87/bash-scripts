#!/bin/bash

if ! [[ $1 || $2 ]]; then
  echo "PLEASE USE THIS SCRIPT AS"
  echo "backup.sh [SOURCE_DEST] [BACKUP_DEST]"
  exit 1
fi

if ! [[ -d "$2" ]]; then
  echo "DESTINATION MUST BE A DIR"
  exit 2
fi

# get the curr date to include in backup
DATE=$(date +%Y%m%d_%H%M%S)

# Create a backup file with a timestamp of current date
BACKUP_FILE="$2/backup_$DATE.tar.gz"

#Create the backup 
echo "Backing up $1 to $2"
tar -czf "$BACKUP_FILE" "$1"

if [[ $? -eq 0 ]]; then
echo "Backup completed sucessfully!"
else
echo "Backup failed"
fi

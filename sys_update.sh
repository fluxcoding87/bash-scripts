#!/bin/bash

# Update package list
echo "Updating Package lists..."
sudo apt update -y

# Upgrade installed packages
echo "Upgrading installed packages..."
sudo apt upgrade -y

# Clean up unnecessary packages
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt clean

echo "System updated completed sucessfully!"

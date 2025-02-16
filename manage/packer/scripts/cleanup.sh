#!/bin/bash
# cleanup.sh
# This script cleans up temporary files and prepares the OS for imaging.

echo "Starting cleanup process..."

# Clean up APT cache
sudo apt-get clean

# Remove logs and temporary files
sudo rm -rf /var/log/*
sudo rm -rf /tmp/*

# Optionally, remove SSH host keys to ensure new ones are generated upon first boot
sudo rm -f /etc/ssh/ssh_host_*

echo "Cleanup completed."
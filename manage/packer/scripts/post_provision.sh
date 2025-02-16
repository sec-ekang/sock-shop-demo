#!/bin/bash
# post_provision.sh
# This script runs additional provisioning commands after the main cleanup.

echo "Running post-provisioning steps..."

# Update package index and upgrade installed packages
sudo apt-get update
sudo apt-get upgrade -y

# (Optional) Install any additional packages or perform further configuration here
# e.g., sudo apt-get install -y vim htop

echo "Post-provisioning completed."
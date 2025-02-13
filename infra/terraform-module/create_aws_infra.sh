#!/bin/bash
# create_infra.sh
# This script automates Terraform infrastructure creation.
# It supports three environments: Dev, QA, and Prod.
# - Dev and QA can be created multiple times with unique names.
# - Prod can be created only once.
#
# Folder structure:
# ├── dev/       # Contains main.tf, variables.tf for Dev environment
# ├── qa/        # Contains main.tf, variables.tf for QA environment
# └── prod/      # Contains main.tf, variables.tf for Prod environment
#
# Usage: Run this script from the root directory containing the dev, qa, prod folders.

# Function to exit on error
function exit_on_error() {
    echo "Error: $1"
    exit 1
}

echo "======================================"
echo "Terraform Infrastructure Creation Tool"
echo "======================================"
echo "Select the environment you want to create:"
echo "1) Dev"
echo "2) QA"
echo "3) Prod"
read -p "Enter your choice [1-3]: " choice

case "$choice" in
  1)
    env="dev"
    dir="dev"
    ;;
  2)
    env="qa"
    dir="qa"
    ;;
  3)
    env="prod"
    dir="prod"
    ;;
  *)
    exit_on_error "Invalid choice. Exiting."
    ;;
esac

# For Prod, ensure only one can be created using a marker file
if [ "$env" == "prod" ]; then
    if [ -f "$dir/prod.lock" ]; then
        exit_on_error "Prod environment already exists. Cannot create another Prod environment."
    fi
fi

# For Dev and QA, ask for a unique instance name; Prod uses a fixed name
if [ "$env" == "dev" ] || [ "$env" == "qa" ]; then
    read -p "Enter a unique name for the ${env} environment (e.g., instance1): " instance_name
    # Remove spaces and unwanted characters if needed
    workspace="${env}-${instance_name}"
else
    workspace="$env"
fi

echo "Selected environment workspace: $workspace"

# Change directory to the appropriate environment folder
echo "Changing directory to the '$dir' folder..."
cd "$dir" || exit_on_error "Directory '$dir' not found."

# Initialize Terraform
echo "Initializing Terraform in the $env environment..."
terraform init || exit_on_error "Terraform init failed."

# Check if the workspace exists; if not, create it, otherwise select it.
if terraform workspace list | grep -qE "^\*?[[:space:]]*$workspace\$"; then
    echo "Selecting existing workspace: $workspace"
    terraform workspace select "$workspace" || exit_on_error "Failed to select workspace."
else
    echo "Creating new workspace: $workspace"
    terraform workspace new "$workspace" || exit_on_error "Failed to create workspace."
fi

# Run Terraform apply (auto approve for automation)
echo "Applying Terraform configuration..."
terraform apply -auto-approve || exit_on_error "Terraform apply failed."

# For Prod, create the marker file so that it cannot be created again.
if [ "$env" == "prod" ]; then
    touch prod.lock || exit_on_error "Failed to create prod marker file."
fi

echo "Infrastructure creation for '$workspace' environment completed successfully."
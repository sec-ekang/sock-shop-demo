# Packer Custom Image Project

This project uses Packer to build a custom Ubuntu image from a source virtual machine. The build is executed on one Ubuntu machine (with Packer installed) using a source VM from another Ubuntu machine.

## Overview

- **Source VM**: Ubuntu Linux Machine #2 that is prepared for imaging.
- **Build Machine**: Ubuntu Linux Machine #1 where Packer is installed.
- **Packer Configuration**: Uses the `vmware-vmx` builder to create a custom image.
- **Provisioners**: Two shell scripts are used:
  - `cleanup.sh`: Cleans up the source VM before imaging.
  - `post_provision.sh`: Runs additional configuration after the main provisioning.
- **Post-Processor**: Converts the final image into a Vagrant box and saves it in the `output/` directory.

## How to Use

1. **Edit Variables**:  
   Modify `variables.pkr.hcl` to reflect the correct paths and credentials for your source VM.

2. **Run Packer Build**:  
   From the project root, run:
   ```bash
   packer init ubuntu-custom.pkr.hcl
   packer build ubuntu-custom.pkr.hcl

3. **Run Pakcer Build with Secret Management**:
   ```bash
   export SSH_PASSWORD="your_secret_password"
   packer build -var 'ssh_password=$SSH_PASSWORD' ubuntu-custom.pkr.hcl
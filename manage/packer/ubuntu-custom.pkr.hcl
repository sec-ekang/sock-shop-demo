---

### File: `ubuntu-custom.pkr.hcl`

```hcl
packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

# Load variables from variables.pkr.hcl
variable "source_vmx" {
  type        = string
  description = "Path to the source VM's .vmx file"
}

variable "ssh_username" {
  type        = string
  description = "SSH username for the source VM"
}

variable "ssh_password" {
  type        = string
  description = "SSH password for the source VM"
}

source "vmware-vmx" "ubuntu_custom" {
  # The path to the source VM's .vmx file (provided via variables)
  vmx_data = var.source_vmx

  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  shutdown_command = "sudo shutdown -P now"

  # Adjust additional builder settings as needed
}

build {
  name    = "ubuntu-custom"
  sources = [
    "source.vmware-vmx.ubuntu_custom"
  ]

  # Run cleanup script to prepare the OS
  provisioner "shell" {
    script = "scripts/cleanup.sh"
  }

  # Run post-provisioning commands (e.g., updates, additional configuration)
  provisioner "shell" {
    script = "scripts/post_provision.sh"
  }

  # Package the output as a Vagrant box
  post-processor "vagrant" {
    output = "output/ubuntu-custom.box"
  }
}
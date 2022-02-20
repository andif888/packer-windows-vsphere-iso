packer {
  required_plugins {
    vsphere = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/vsphere"
    }

    # if you would like to automatically install window updates, then uncomment
    # the following section. Please also uncomment Line 163-170

    # windows-update = {
    #   version = "0.14.0"
    #   source = "github.com/rgl/windows-update"
    # }

  }
}

variable "autounattend_file" {
  type    = string
  default = ""
}

variable "cpu_num" {
  type    = number
  default = 2
}

variable "disk_size" {
  type    = number
  default = 102400
}

variable "mem_size" {
  type    = number
  default = 4096
}

variable "os_iso_checksum" {
  type    = string
  default = ""
}

variable "os_iso_url" {
  type    = string
  default = ""
}

variable "vmtools_iso_path" {
  type    = string
  default = ""
}

variable "floppy_pvscsi" {
  type = string
  default = ""
}

variable "vsphere_datastore" {
  type    = string
  default = ""
}

variable "vsphere_datacenter" {
  type    = string
  default = ""
}

variable "vsphere_guest_os_type" {
  type    = string
  default = ""
}

variable "vsphere_host" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "vsphere_network" {
  type    = string
  default = ""
}

variable "vsphere_server" {
  type    = string
  default = ""
}

variable "vsphere_vm_name" {
  type    = string
  default = ""
}

variable "vsphere_username" {
  type    = string
  default = ""
}

variable "winrm_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "winrm_username" {
  type    = string
  default = ""
}

source "vsphere-iso" "windows" {

  vcenter_server        = "${var.vsphere_server}"
  host                  = "${var.vsphere_host}"
  username              = "${var.vsphere_username}"
  password              = "${var.vsphere_password}"
  insecure_connection  = "true"
  datacenter            = "${var.vsphere_datacenter}"
  datastore             = "${var.vsphere_datastore}"

  CPUs                  = "${var.cpu_num}"
  RAM                   = "${var.mem_size}"
  RAM_reserve_all       = true
  disk_controller_type  = ["pvscsi"]
  # firmware             = "bios"
  floppy_files          = ["${var.autounattend_file}", "setup/setup.ps1", "setup/vmtools.cmd", "setup/appx.ps1"]
  floppy_img_path       = "${var.floppy_pvscsi}"
  guest_os_type         = "${var.vsphere_guest_os_type}"
  iso_checksum          = "${var.os_iso_checksum}"
  iso_url               = "${var.os_iso_url}"
  iso_paths             = ["${var.vmtools_iso_path}"]

  network_adapters {
    network             = "${var.vsphere_network}"
    network_card        = "vmxnet3"
  }

  storage {
    disk_size             = "${var.disk_size}"
    disk_thin_provisioned = true
  }

  vm_name               = "${var.vsphere_vm_name}"
  convert_to_template   = "true"
  communicator          = "winrm"
  winrm_username        = "${var.winrm_username}"
  winrm_password        = "${var.winrm_password}"
  winrm_timeout         = "3h"

  shutdown_timeout      = "60m"

  ip_wait_timeout       = "3h"
  ip_settle_timeout     = "2m"
}

build {
  sources = ["source.vsphere-iso.windows"]

  # if you would like to automatically install window updates, then uncomment
  # the following section. Please also uncomment Line 11-14

  # provisioner "windows-update" {
  #   search_criteria = "IsInstalled=0"
  #   filters = [
  #     "exclude:$_.Title -like '*Preview*'",
  #     "include:$true",
  #   ]
  #   update_limit = 25
  # }

  provisioner "windows-shell" {
    inline = ["dir c:\\"]
  }

}

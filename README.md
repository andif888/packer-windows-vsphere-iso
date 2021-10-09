# packer-windows-vsphere-iso

This repo builds automatically Windows VM templates (Windows 11, Windows 10, Server 2019, Server 2022) for VMware vSphere environment using Hashicorp's Packer using freely available Windows Eval ISOs.  

With this repo VM templates for the following Windows operating systems can be built.

- Windows 10 Enterprise
- Windows 11 Enterprise
- Windows Server 2019 Datacenter
- Windows Server 2022 Datacenter

You don't need do pre-download any Windows ISO.
Windows ISO files gets download automatically from public sources.

## How to use this repo

### Pre-requesites 

Download or `git clone https://github.com/andif888/packer-windows-vsphere-iso.git` this repo and make sure you have [Packer](https://www.packer.io/downloads) Version 1.7.1 or later installed. If you don't know Packer, it's a single commandline binary which only needs to be on your `PATH`.

### Step 1: Adjust variables

Rename the file [variables.auto.pkrvars.hcl.sample](variables.auto.pkrvars.hcl.sample) to `variables.auto.pkrvars.hcl` and adjust the variables for your VMware vSphere environment. Some documentation on each variable is inside the sample file.
```bash
mv variables.auto.pkrvars.hcl.sample variables.auto.pkrvars.hcl
nano variables.auto.pkrvars.hcl
```

### Step 2: Init Packer

Init Packer by using the following command. (Spot the dot at the end of the command!)
```bash
packer init .
``` 

### Step 3: Build a VM Template

To build a VM template run one of the provided `build`-scripts.   
For example to build a Windows 11 template run: 
```bash
./build-11.sh
``` 
If you are on a Windows machine then use the `build-*.ps1` files.


### Optional: Windows Template default credentials

the default credentials after a successful build are   
Username: `vagrant`   
Password: `vagrant`  
    
If you would like to change the default ćredentials before a packer build, then you need to edit the following files: 

- **variables.auto.pkrvars.hcl**
- **autounattend.xml** 

### Optional: Install Windows Updates during build

You can optionally install Windows Updates during the build operation. 
If you would like this feature then you need to edit the [windows.pkr.hcl](windows.pkr.hcl) file before the build operation. Please uncomment the following sections:  
  
Line: 11-14
```hcl
    windows-update = {
      version = "0.14.0"
      source = "github.com/rgl/windows-update"
    }
```
Line: 163-170
```hcl
  provisioner "windows-update" {
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
      "include:$true",
    ]
    update_limit = 25
  }
```
After that you have to run `packer init .` again to automatically download the Packer Windows-Update Plugin.
```bash
packer init .
```

## Windows 11 - BypassTPMCheck

Normaly Windows 11 requires a TPM to get installed successfully. 
VMware vSphere provides a virtualized TPM since Version 6.7 and later. 
In this repo we do not configure a vTPM in vSphere for Windows 11.   
Instead we use a easy workaround to turn off TPM check during Windows 11 installation.   
In the [autounattend.xml](answer_files/11/en/autounattend.xml) we add some registrykeys which effectively enable the **BypassTPMCheck** in Windows 11.

```xml
    <RunSynchronousCommand wcm:action="add">
        <Order>1</Order>
        <Description>BypassTPMCheck</Description>
        <Path>cmd /c reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d 1</Path>
    </RunSynchronousCommand>
    <RunSynchronousCommand wcm:action="add">
        <Order>2</Order>
        <Description>BypassSecureBootCheck</Description>
        <Path>cmd /c reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d 1</Path>
    </RunSynchronousCommand>
    <RunSynchronousCommand wcm:action="add">
        <Order>3</Order>
        <Description>BypassRAMCheck</Description>
        <Path>cmd /c reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d 1</Path>
    </RunSynchronousCommand>
```

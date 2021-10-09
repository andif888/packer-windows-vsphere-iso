#!/bin/bash
# variable files ending with .auto.pkrvars.hcl are automatically loaded
packer build \
  -var='os_iso_checksum=e8b1d2a1a85a09b4bf6154084a8be8e3c814894a15a7bcf3e8e63fcfa9a528cb' \
  -var='os_iso_url=https://software-download.microsoft.com/download/sg/22000.194.210913-1444.co_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso' \
  -var='vsphere_guest_os_type=windows9_64Guest' \
  -var='vsphere_vm_name=tpl-windows-11-eval' \
  -var='autounattend_file=answer_files/11/en/autounattend.xml' .

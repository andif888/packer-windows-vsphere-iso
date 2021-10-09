#!/bin/bash
# variable files ending with .auto.pkrvars.hcl are automatically loaded
packer build \
  -var='os_iso_checksum=549bca46c055157291be6c22a3aaaed8330e78ef4382c99ee82c896426a1cee1' \
  -var='os_iso_url=https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso' \
  -var='vsphere_guest_os_type=windows2019srv_64Guest' \
  -var='vsphere_vm_name=tpl-windows-2019-eval' \
  -var='autounattend_file=answer_files/2019/en/autounattend.xml' .

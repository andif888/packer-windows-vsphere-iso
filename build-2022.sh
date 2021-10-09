#!/bin/bash
# variable files ending with .auto.pkrvars.hcl are automatically loaded
packer build \
  -var='os_iso_checksum=4f1457c4fe14ce48c9b2324924f33ca4f0470475e6da851b39ccbf98f44e7852' \
  -var='os_iso_url=https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso' \
  -var='vsphere_guest_os_type=windows2019srv_64Guest' \
  -var='vsphere_vm_name=tpl-windows-2022-eval' \
  -var='autounattend_file=answer_files/2022/en/autounattend.xml' .

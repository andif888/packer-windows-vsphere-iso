
# variable files ending with .auto.pkrvars.hcl are automatically loaded
packer build `
  -var='os_iso_checksum=026607e7aa7ff80441045d8830556bf8899062ca9b3c543702f112dd6ffe6078' `
  -var='os_iso_url=https://software-download.microsoft.com/download/sg/19043.928.210409-1212.21h1_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso' `
  -var='vsphere_guest_os_type=windows9_64Guest' `
  -var='vsphere_vm_name=tpl-windows-10-eval' `
  -var='autounattend_file=answer_files/10/en/autounattend.xml' .

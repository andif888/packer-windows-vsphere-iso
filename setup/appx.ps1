Get-AppXPackage | Where {($_.NonRemovable -eq $false) -and ($_.IsFramework -eq $false)} | Remove-AppXPackage -ErrorAction SilentlyContinue

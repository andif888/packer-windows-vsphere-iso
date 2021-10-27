Get-AppXPackage | Where {($_.name -like "*edge*")} | Remove-AppXPackage -ErrorAction SilentlyContinue
Get-AppXPackage | Where {($_.name -like "*549981C3F5F1*")} | Remove-AppXPackage -ErrorAction SilentlyContinue
Get-AppXPackage | Where {($_.name -like "*Bing*")} | Remove-AppXPackage -ErrorAction SilentlyContinue
Get-AppXPackage | Where {($_.name -like "*OneDrive*")} | Remove-AppXPackage -ErrorAction SilentlyContinue
Get-AppXPackage | Where {($_.NonRemovable -eq $false) -and ($_.IsFramework -eq $false)} | Remove-AppXPackage -ErrorAction SilentlyContinue
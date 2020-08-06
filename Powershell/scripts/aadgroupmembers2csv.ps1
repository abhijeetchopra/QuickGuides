#Exports users from a group to a csv in the working directory
$mail = Read-Host "Enter Group Email Address: "
Connect-AzureAD
Get-AzureADGroupMember -objectID (Get-AzureADGroup -All 1 | where { $_.Mail -eq $mail}).ObjectId -All 1 | Select-Object `
UserPrincipalName,`
Mail,`
MailNickName,`
DisplayName,`
GivenName,`
Surname,`
JobTitle,`
Department,`
CompanyName,`
StreetAddress,`
City,`
State,`
PostalCode,`
Country,`
TelephoneNumber,`
Mobile,`
PhysicalDeliveryOfficeName,`
UsageLocation,`
AccountEnabled`
 | Export-Csv -Path .\AADGroupMembers_$((Get-AzureADGroup -All 1 | where { $_.Mail -eq $mail}).DisplayName)_$((Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")).csv -NoTypeInformation

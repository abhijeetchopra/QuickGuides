# QuickGuide | Powershell

```ps1

# Active Directory

net user johndoe

Get-ADUser -Identity johndoe -Properties AccountLockoutTime,LastBadPasswordAttempt,BadPwdCount,LockedOut,LastLogonDate

# get a cname resource record
Get-DnsServerResourceRecord -ZoneName "contoso.com" -Name "labsrv1"

# add a cname resource record
Add-DnsServerResourceRecordCName -Name "labsrv1" -HostNameAlias "srv1.lab.contoso.com" -ZoneName "contoso.com"

("foo1",`
"foo2",`
"foo3",`
"foo4",`
"foo5",`
"foo6") | foreach { Get-DnsServerResourceRecord -ZoneName "contoso.com" -Name $_ }

```

## References

- <https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-4.5.0>
- <https://docs.microsoft.com/en-us/powershell/module/dnsserver/add-dnsserverresourcerecordcname?view=win10-ps>

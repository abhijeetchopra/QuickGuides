# QuickGuide | Powershell

## Active Directory

### User Accounts

```ps1
PS > net user johndoe

PS > Get-ADUser -Identity johndoe -Properties AccountLockoutTime,LastBadPasswordAttempt,BadPwdCount,LockedOut,LastLogonDate
```

### DNS Records


#### Get a cname resource record

```ps1
PS > Get-DnsServerResourceRecord -ZoneName "contoso.com" -Name "labsrv1"
```

#### Add a cname resource record

```ps1
Add-DnsServerResourceRecordCName -Name "labsrv1" -HostNameAlias "srv1.lab.contoso.com" -ZoneName "contoso.com"

PS > ("foo1",`
"foo2",`
"foo3",`
"foo4",`
"foo5",`
"foo6") | foreach { Get-DnsServerResourceRecord -ZoneName "contoso.com" -Name $_ }
```


#### Add a cname resource record

```ps1

PS > Add-DnsServerResourceRecordCName -Name "examplesubdomain" -HostNameAlias "secondwebsite.com" -ZoneName "website.com"
```

```ps1
#### Get a cname resource record
PS > Get-DnsServerResourceRecord -ZoneName "website.com" -Name "examplesubdomain"

HostName                  RecordType Type       Timestamp            TimeToLive      RecordData
--------                  ---------- ----       ---------            ----------      ----------
grid                      CNAME      5          0                    00:05:00        secondwebsite.com
```

#### Add multiple cname resource records

```ps1
PS > ("foo-one",`
>> "foo-two",`
>> "foo-three",`
>> "foo-four",`
>> "foo-five",`
>> "foo-six",`
>> "foo-seven",`
>> "foo-eight") | foreach { Add-DnsServerResourceRecordCName -Name $_ -HostNameAlias "secondwebsite.com" -ZoneName "website.com" }
```

#### Get multiple cname resource records

```ps1
PS > ("foo-one",`
>> "foo-two",`
>> "foo-three",`
>> "foo-four",`
>> "foo-five",`
>> "foo-six",`
>> "foo-seven",`
>> "foo-eight") | foreach { Get-DnsServerResourceRecord -ZoneName "website.com" -Name $_ }

```

## References

- <https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-4.5.0>
- <https://docs.microsoft.com/en-us/powershell/module/dnsserver/add-dnsserverresourcerecordcname?view=win10-ps>

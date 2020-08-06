# QuickGuide | Powershell

```ps1

# Active Directory

net user johndoe

Get-ADUser -Identity johndoe -Properties AccountLockoutTime,LastBadPasswordAttempt,BadPwdCount,LockedOut,LastLogonDate

```

## References

- <https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-4.5.0>
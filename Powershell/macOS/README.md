# QuickGuide | Powershell - macOS

## Installing Powershell on macOS

<https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7>

```bash
# install
brew cask install powershell

# update
brew update
brew cask upgrade powershell
```

## Installing Azure PowerShell on macOS

<https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-4.5.0>

## Sign in to Azure

```ps1

# Connect to Azure with a browser sign in token
Connect-AzAccount

```

## Active Directory

```ps1

net user johndoe

Get-ADUser -Identity johndoe -Properties AccountLockoutTime,LastBadPasswordAttempt,BadPwdCount,LockedOut,LastLogonDate

```

## Azure Active Directory

```ps1



```

## References

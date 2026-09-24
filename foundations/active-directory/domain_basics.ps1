Import-Module ActiveDirectory

Get-ADDomain | Select-Object DNSRoot, DomainMode, PDCEmulator
Get-ADForest | Select-Object RootDomain, ForestMode
Get-ADDomainController -Filter * | Select-Object HostName, Site, IsGlobalCatalog

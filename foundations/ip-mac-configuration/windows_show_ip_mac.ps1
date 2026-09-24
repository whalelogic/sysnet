Get-NetIPAddress -AddressFamily IPv4 |
  ForEach-Object {
    $adapter = Get-NetAdapter -InterfaceIndex $_.InterfaceIndex -ErrorAction SilentlyContinue
    [PSCustomObject]@{
      InterfaceAlias = $_.InterfaceAlias
      IPAddress      = $_.IPAddress
      PrefixLength   = $_.PrefixLength
      MacAddress     = $adapter.MacAddress
    }
  }

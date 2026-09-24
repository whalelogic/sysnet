param(
  [string]$Cidr = "192.168.10.0/24"
)

if ($Cidr -notmatch '^\d+\.\d+\.\d+\.0/24$') {
  Write-Error "Only /24 ranges ending in .0 are supported in this starter script."
  exit 1
}

$base = $Cidr.Split('/')[0]
$octets = $base.Split('.')
$prefix = "$($octets[0]).$($octets[1]).$($octets[2])"

1..254 | ForEach-Object {
  $ip = "$prefix.$_"
  if (Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue) {
    Write-Output $ip
  }
}



1..254 | ForEach-Object { Test-Connection -ComputerName "192.168.1.$_" -Count 1 -TimeoutMilliSecs 100 -Quiet }
Get-NetNeighbor | Where-Object { $_.IPAddress -like "192.168.1.*" } | Select-Object IPAddress, LinkLayerAddress

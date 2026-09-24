#!/usr/bin/env bash
set -euo pipefail

ip -o -4 addr show | while read -r _ iface addr _; do
  mac=$(cat "/sys/class/net/${iface}/address")
  echo "${iface} ${addr} ${mac}"
done

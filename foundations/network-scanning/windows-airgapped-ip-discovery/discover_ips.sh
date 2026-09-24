#!/usr/bin/env bash
set -euo pipefail

CIDR="${1:-192.168.10.0/24}"

if [[ ! "$CIDR" =~ ^([0-9]{1,3}\.){3}0/24$ ]]; then
  echo "Only /24 ranges ending in .0 are supported in this starter script." >&2
  exit 1
fi

BASE="${CIDR%/*}"
PREFIX="${BASE%.*}"

for i in $(seq 1 254); do
  ip="${PREFIX}.${i}"
  if ping -c 1 -W 1 "$ip" >/dev/null 2>&1; then
    echo "$ip"
  fi
done

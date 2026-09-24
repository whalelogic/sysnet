#!/usr/bin/env bash
set -euo pipefail

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This starter script currently supports Debian/Ubuntu systems with apt-get." >&2
  exit 1
fi

sudo apt-get update
sudo apt-get install -y nmap netcat-openbsd

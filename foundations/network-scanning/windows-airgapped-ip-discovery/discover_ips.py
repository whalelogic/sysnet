#!/usr/bin/env python3
import ipaddress
import platform
import subprocess
import sys


def ping_host(ip: str) -> bool:
    if platform.system().lower().startswith("win"):
        cmd = ["ping", "-n", "1", "-w", "300", ip]
    else:
        cmd = ["ping", "-c", "1", "-W", "1", ip]

    result = subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=False)
    return result.returncode == 0


def main() -> int:
    cidr = sys.argv[1] if len(sys.argv) > 1 else "192.168.10.0/24"

    try:
        network = ipaddress.ip_network(cidr, strict=True)
    except ValueError as exc:
        print(f"Invalid CIDR '{cidr}': {exc}", file=sys.stderr)
        return 1

    for host in network.hosts():
        host_ip = str(host)
        if ping_host(host_ip):
            print(host_ip)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

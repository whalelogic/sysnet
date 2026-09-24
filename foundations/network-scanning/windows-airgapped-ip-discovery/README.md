# Windows Air-Gapped IP Discovery

These starter scripts identify likely live hosts on a provided IPv4 `/24` network range.

## Files

- `discover_ips.ps1` - PowerShell ping sweep (Windows-first workflow).
- `discover_ips.py` - Python implementation using system ping.
- `discover_ips.sh` - Bash implementation for Linux or WSL.
- `discover_ips.go` - Go implementation with bounded concurrency.
- `discover_ips.rs` - Rust implementation (sequential baseline).

> Default CIDR is `192.168.10.0/24` and can be changed with a script argument.

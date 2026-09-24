use std::env;
use std::process::Command;

fn ping_host(ip: &str) -> bool {
    let output = if cfg!(target_os = "windows") {
        Command::new("ping").args(["-n", "1", "-w", "300", ip]).output()
    } else {
        Command::new("ping").args(["-c", "1", "-W", "1", ip]).output()
    };

    output.map(|o| o.status.success()).unwrap_or(false)
}

fn main() {
    let cidr = env::args().nth(1).unwrap_or_else(|| "192.168.10.0/24".to_string());
    let parts: Vec<&str> = cidr.split('/').collect();

    if parts.len() != 2 || parts[1] != "24" {
        eprintln!("Only IPv4 /24 CIDR is supported in this starter script.");
        std::process::exit(1);
    }

    let octets: Vec<&str> = parts[0].split('.').collect();
    if octets.len() != 4 {
        eprintln!("Invalid IPv4 network base.");
        std::process::exit(1);
    }

    let prefix = format!("{}.{}.{}", octets[0], octets[1], octets[2]);
    for host in 1..=254 {
        let ip = format!("{}.{}", prefix, host);
        if ping_host(&ip) {
            println!("{}", ip);
        }
    }
}

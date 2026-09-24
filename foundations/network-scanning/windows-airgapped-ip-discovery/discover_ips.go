package main

import (
	"fmt"
	"net"
	"os"
	"runtime"
	"sync"
	"time"
)

func pingHost(ip string) bool {
	timeout := 350 * time.Millisecond
	conn, err := net.DialTimeout("tcp", net.JoinHostPort(ip, "135"), timeout)
	if err == nil {
		_ = conn.Close()
		return true
	}
	return false
}

func main() {
	cidr := "192.168.10.0/24"
	if len(os.Args) > 1 {
		cidr = os.Args[1]
	}

	ip, ipNet, err := net.ParseCIDR(cidr)
	if err != nil {
		fmt.Fprintf(os.Stderr, "invalid CIDR: %v\n", err)
		os.Exit(1)
	}

	base := ip.To4()
	if base == nil || ipNet.Mask.String() != "ffffff00" {
		fmt.Fprintln(os.Stderr, "only IPv4 /24 CIDR is supported in this starter script")
		os.Exit(1)
	}

	prefix := fmt.Sprintf("%d.%d.%d", base[0], base[1], base[2])
	workers := runtime.NumCPU()
	jobs := make(chan string)
	results := make(chan string)
	var wg sync.WaitGroup

	for i := 0; i < workers; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for host := range jobs {
				if pingHost(host) {
					results <- host
				}
			}
		}()
	}

	go func() {
		for i := 1; i <= 254; i++ {
			jobs <- fmt.Sprintf("%s.%d", prefix, i)
		}
		close(jobs)
		wg.Wait()
		close(results)
	}()

	for host := range results {
		fmt.Println(host)
	}
}

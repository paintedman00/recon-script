# Reconnaissance Script

A bash script to perform comprehensive reconnaissance on a specified target domain. The script includes DNS enumeration, WHOIS lookup, HTTP enumeration, subdomain extraction, directory scanning, and subdomain takeover checks.

## Overview

This script automates the process of gathering information about a target domain. It saves the results of each step in a specified output directory.

## Usage

1. **Download the Script:**

    Save the script to a file, e.g., `recon-script.sh`.

2. **Make the Script Executable:**

    ```bash
    chmod +x recon-script.sh
    ```

3. **Run the Script:**

    ```bash
    ./recon-script.sh
    ```

### Example Output

```
[*] Performing DNS enumeration...
[*] Performing WHOIS lookup...
[*] Performing HTTP enumeration...
[*] Extracting subdomains...
[*] Performing directory scanning...
[*] Performing subdomain takeover checks...
```

## Script Details

### Variables

- `TARGET`: The domain to be scanned (default is `"example.com"`).
- `OUTPUT_DIR`: The directory where results will be saved (default is `"recon_results"`).

### Script Steps

1. **Create Output Directory:**

    The script creates the output directory if it doesn't already exist.

    ```bash
    mkdir -p $OUTPUT_DIR
    ```

2. **Perform DNS Enumeration:**

    The script uses `dnsrecon` to perform DNS enumeration and saves the results.

    ```bash
    echo "[*] Performing DNS enumeration..."
    dnsrecon -d $TARGET -t std -o $OUTPUT_DIR/dns_enum.txt
    ```

3. **Perform WHOIS Lookup:**

    The script performs a WHOIS lookup and saves the results.

    ```bash
    echo "[*] Performing WHOIS lookup..."
    whois $TARGET > $OUTPUT_DIR/whois.txt
    ```

4. **Perform HTTP Enumeration:**

    The script uses `nmap` to perform HTTP enumeration and saves the results.

    ```bash
    echo "[*] Performing HTTP enumeration..."
    nmap -sV -p 80,443 $TARGET > $OUTPUT_DIR/http_enum.txt
    ```

5. **Extract Subdomains:**

    The script uses `sublist3r` to extract subdomains and saves the results.

    ```bash
    echo "[*] Extracting subdomains..."
    sublist3r -d $TARGET -o $OUTPUT_DIR/subdomains.txt
    ```

6. **Perform Directory Scanning:**

    The script uses `gobuster` to perform directory scanning and saves the results.

    ```bash
    echo "[*] Performing directory scanning..."
    gobuster dir -w /usr/share/wordlists/dirb/common.txt -u http://$TARGET -o $OUTPUT_DIR/directory_scan.txt
    ```

7. **Perform Subdomain Takeover Checks:**

    The script uses `subjack` to check for subdomain takeovers and saves the results.

    ```bash
    echo "[*] Performing subdomain takeover checks..."
    subjack -w $OUTPUT_DIR/subdomains.txt -t 100 -timeout 30 -ssl -c /root/go/src/github.com/haccer/subjack/fingerprints.json -v 3 > $OUTPUT_DIR/subdomain_takeover.txt
    ```

## Dependencies

Ensure the following tools are installed and available on your system:

- `dnsrecon`
- `whois`
- `nmap`
- `sublist3r`
- `gobuster`
- `subjack`

### Installation

For Debian/Ubuntu, you can install the dependencies using the following commands:

```bash
sudo apt-get install dnsrecon whois nmap gobuster
pip install sublist3r
go get github.com/haccer/subjack
```

For other distributions, use the appropriate package manager or installation method.

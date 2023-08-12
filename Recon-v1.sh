#!/bin/bash

TARGET="example.com"
OUTPUT_DIR="recon_results"

# Create the output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Perform DNS enumeration
echo "[*] Performing DNS enumeration..."
dnsrecon -d $TARGET -t std -o $OUTPUT_DIR/dns_enum.txt

# Perform WHOIS lookup
echo "[*] Performing WHOIS lookup..."
whois $TARGET > $OUTPUT_DIR/whois.txt

# Perform HTTP enumeration
echo "[*] Performing HTTP enumeration..."
nmap -sV -p 80,443 $TARGET > $OUTPUT_DIR/http_enum.txt

# Extract subdomains using Sublist3r
echo "[*] Extracting subdomains..."
sublist3r -d $TARGET -o $OUTPUT_DIR/subdomains.txt

# Perform directory scanning
echo "[*] Performing directory scanning..."
gobuster dir -w /usr/share/wordlists/dirb/common.txt -u http://$TARGET -o $OUTPUT_DIR/directory_scan.txt

# Perform subdomain takeover checks
echo "[*] Performing subdomain takeover checks..."
subjack -w $OUTPUT_DIR/subdomains.txt -t 100 -timeout 30 -ssl -c /root/go/src/github.com/haccer/subjack/fingerprints.json -v 3 > $OUTPUT_DIR/subdomain_takeover.txt



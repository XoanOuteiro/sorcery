#!/bin/bash

echo -e "--[風雅]--\n"

echo "--[Enumerating Ports]--"

# Get targets open ports via SYN scan
export PORTS=$(sudo nmap -sS -p- -T4 $TARGET | grep "/tcp" | grep "open" | awk -F "/" '{print $1}' | paste -sd,)

echo "--[Scanning]--"
# Aggressive scan on open ports (port 1 is added to aid OS detection)
export SCAN_OUTPUT=$(sudo nmap -sS -A -p 1,$PORTS $TARGET)

echo -e "\n--[Detected Services]--\n"
printf "%-20s | %s\n" "Service" "Version"
printf "%-20s-+-%s\n" "--------------------" "-------------------------"

# Extract and display service information
echo "$SCAN_OUTPUT" | grep "open" | awk '/^[0-9]+\/tcp/ {
    svc = $3
    ver = ""
    for (i=4; i<=NF; i++) ver = ver (i>4?" ":"") $i
    printf "%-20s | %s\n", svc, ver
}'

# Extract and display OS fingerprinting information
echo -e "\n--[Host Fingerprinting]--\n"
printf "%-20s | %s\n" "Category" "Details"
printf "%-20s-+-%s\n" "--------------------" "-------------------------"

# Extract device type
DEVICE=$(echo "$SCAN_OUTPUT" | grep "Device type:" | sed 's/Device type: //')
if [ -n "$DEVICE" ]; then
    printf "%-20s | %s\n" "Device Type" "$DEVICE"
fi

# Extract Running OS
RUNNING=$(echo "$SCAN_OUTPUT" | grep "Running:" | sed 's/Running: //')
if [ -n "$RUNNING" ]; then
    printf "%-20s | %s\n" "Running" "$RUNNING"
fi

# Extract OS details
OS_DETAILS=$(echo "$SCAN_OUTPUT" | grep "OS details:" | sed 's/OS details: //')
if [ -n "$OS_DETAILS" ]; then
    printf "%-20s | %s\n" "OS Details" "$OS_DETAILS"
fi

# Extract OS CPE
OS_CPE=$(echo "$SCAN_OUTPUT" | grep "OS CPE:" | sed 's/OS CPE: //')
if [ -n "$OS_CPE" ]; then
    printf "%-20s | %s\n" "OS CPE" "$OS_CPE"
fi

# Extract service info OS
SERVICE_OS=$(echo "$SCAN_OUTPUT" | grep "Service Info:" | sed 's/Service Info: //' | grep -o "OS: [^;]*" | sed 's/OS: //')
if [ -n "$SERVICE_OS" ]; then
    printf "%-20s | %s\n" "Service OS" "$SERVICE_OS"
fi

#!/bin/bash

# Function to display total CPU usage
function cpu_usage {
    echo "Total CPU Usage:"
    mpstat | awk '$3 ~ /[0-9.]+/ { print "CPU Usage: " 100 - $12 "%"}'
    echo
}

# Function to display total memory usage
function memory_usage {
    echo "Total Memory Usage:"
    free -h | awk 'NR==2{printf "Used: %s, Free: %s, Total: %s (%.2f%% used)\n", $3, $4, $2, $3*100/$2}'
    echo
}

# Function to display total disk usage
function disk_usage {
    echo "Total Disk Usage:"
    df -h | awk '$NF=="/"{printf "Used: %s, Free: %s, Total: %s (%.2f%% used)\n", $3, $4, $2, $3*100/$2}'
    echo
}

# Function to display top 5 processes by CPU usage
function top_cpu_processes {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo
}

# Function to display top 5 processes by memory usage
function top_memory_processes {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo
}

# Function to display OS version
function os_version {
    echo "Operating System Version:"
    uname -a
    echo
}

# Function to display uptime
function server_uptime {
    echo "Server Uptime:"
    uptime
    echo
}

# Function to display load average
function load_average {
    echo "Load Average:"
    uptime | awk -F'load average:' '{ print $2 }'
    echo
}

# Function to display logged in users
function logged_in_users {
    echo "Logged In Users:"
    who
    echo
}

# Function to display failed login attempts
function failed_login_attempts {
    echo "Failed Login Attempts:"
    sudo cat /var/log/auth.log | grep "Failed password" | wc -l
    echo
}

# Main script execution
echo "=== Server Performance Stats ==="
cpu_usage
memory_usage
disk_usage
top_cpu_processes
top_memory_processes
os_version
server_uptime
load_average
logged_in_users
failed_login_attempts

echo "=== End of Server Performance Stats ==="

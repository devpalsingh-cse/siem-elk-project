#!/usr/bin/env bash
# Generates fake failed-SSH-login entries in auth.log for dashboard testing.
# Use ONLY on your own lab machine. Requires sudo write access to the log file.
#
# Usage: ./simulate_bruteforce.sh [count]

COUNT="${1:-15}"
LOGFILE="/var/log/auth.log"
USERS=("root" "admin" "test" "ubuntu" "guest")
IPS=("203.0.113.10" "198.51.100.23" "192.0.2.77" "203.0.113.99")

for i in $(seq 1 "$COUNT"); do
  TS=$(date "+%b %e %H:%M:%S")
  USER=${USERS[$RANDOM % ${#USERS[@]}]}
  IP=${IPS[$RANDOM % ${#IPS[@]}]}
  PORT=$((RANDOM % 60000 + 1024))
  echo "$TS $(hostname) sshd[$$]: Failed password for invalid user $USER from $IP port $PORT ssh2" \
    | sudo tee -a "$LOGFILE" >/dev/null
  sleep 0.2
done

echo "Wrote $COUNT simulated failed-login events to $LOGFILE"

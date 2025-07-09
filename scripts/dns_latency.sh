#!/bin/bash

# Usage: ./dns_latency.sh <dns_server> <domain>
dns_server="$1"
domain="$2"

if [[ -z "$dns_server" || -z "$domain" ]]; then
  echo 0
  exit 1
fi

kdig_output=$(kdig +noheader +stats @$dns_server $domain 2>/dev/null)
if [[ $? -ne 0 ]]; then
  echo 9999
  exit 1
fi

echo "$kdig_output" | awk '/Query time:/ { print $3 }'

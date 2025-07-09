#!/bin/bash

# Usage: ./dns_latency.sh <dns_server> <domain>
dns_server="$1"
domain="$2"

if [[ -z "$dns_server" || -z "$domain" ]]; then
  echo 0
  exit 1
fi

dig @$dns_server $domain +stats +time=2 2>/dev/null | awk '/Query time:/ { print $4 }'

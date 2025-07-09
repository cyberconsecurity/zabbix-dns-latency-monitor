# zabbix-dns-latency-monitor
This lightweight monitoring utility checks internal and external DNS latency using kdig (from the Knot DNS suite) and integrates with Zabbix Agent for alerting and graphing. This currently checks against 5 external and 3 internal DNS servers.

***Tested on Zabbix version 7.2.10 running on Ubuntu 24.04***

Prerequisites
Install kdig if not already installed:
1. sudo apt update
2. sudo apt install knot-dnsutils

Step-by-Step Setup
1. Download zabbix-dns-latency-monitor-kdig.zip
2. Extract the package:

   unzip zabbix-dns-latency-monitor-kdig.zip
   
   cd zabbix-dns-latency-monitor-kdig
4. Deploy the script and config:

   sudo mkdir -p /etc/zabbix/scripts

   sudo cp scripts/dns_latency.sh /etc/zabbix/scripts/

   sudo chmod +x /etc/zabbix/scripts/dns_latency.sh

   sudo cp etc/zabbix/zabbix_agent2.d/dns_latency.conf /etc/zabbix/zabbix_agent2.d/

5. Edit dns_latency.conf and update the internal DNS server IP

     UserParameter=dns.latency.internal,/etc/zabbix/scripts/dns_latency.sh "your internal DNS server IP" google.com

     UserParameter=dns.latency.external,/etc/zabbix/scripts/dns_latency.sh 1.1.1.1 google.com
7. Restart Zabbix agent:

   sudo systemctl restart zabbix-agent2
8. Test the items locally:

   zabbix_agent2 -t dns.latency.internal
    
   zabbix_agent2 -t dns.latency.external

Zabbix Frontend Configuration
1. Go to: Configuration → Templates → Import
2. Upload: DNS_Latency.xml
3. Link the template to your Zabbix server host
4. Go to Monitoring → Graphs → DNS Latency to view real-time results

To change the Zabbix dashboard to display meaningful labels (e.g., actual DNS server names like 8.8.8.8, 1.1.1.1) instead of keys like DNS Latency External 1.

1. Go to Configuration → Templates
2. Open Template DNS Latency Monitor
3. Click the Items tab
4. Find dns.latency.external1, click on it
5. Change the Name from:

   DNS Latency External 1

   To something like DNS Latency to 8.8.8.8
7. Click Update

Repeat this for each item:
   dns.latency.external2 → DNS Latency to 1.1.1.1
   
   etc.

![Sample_Graph](https://github.com/user-attachments/assets/7e060eec-5f87-4bb3-a372-eac34bc62448)

🛡️ Bash Anti-DDoS Firewall Script (iptables)

This Bash script implements a basic but effective DDoS and flood mitigation mechanism using iptables, primarily designed to protect web services running on ports 80 (HTTP) and 443 (HTTPS).

It is intended for Linux servers exposed to the Internet that require strict inbound traffic control while still allowing legitimate users.

🔐 Key Features

Firewall rule cleanup

Flushes existing rules in the INPUT and FORWARD chains to prevent conflicts.

Trusted IP whitelisting

Allows unrestricted traffic from specific trusted IP addresses (ideal for load balancers, CDNs, administrative IPs, or trusted servers).

Connection limit per IP

Restricts the maximum number of simultaneous TCP connections per IP on ports 80 and 443 to mitigate connection-flood attacks.

SYN Flood protection

Applies rate limiting to new TCP connections (state NEW) to prevent server exhaustion.

Automatically drops connections exceeding the defined thresholds.

ICMP Flood mitigation

Limits ICMP echo requests (ping) to prevent abuse while still allowing basic network diagnostics.

Invalid packet filtering

Drops invalid TCP packets targeting HTTP/HTTPS services.

Legitimate traffic handling

Allows NEW, ESTABLISHED, and RELATED connections for normal web traffic.

Attack logging

Logs dropped packets on ports 80 and 443 for monitoring and forensic analysis.

⚙️ Requirements

Linux operating system

iptables installed

Root privileges

⚠️ Warnings

This script flushes existing firewall rules, so it should not be used on systems with complex firewall configurations without prior review.

It provides perimeter-level protection only and does not replace advanced solutions such as:

Fail2Ban

nftables

Hardware firewalls

WAF or CDN services (Cloudflare, etc.)

📌 Recommended Use Cases

Ideal for:

Small to medium VPS instances

Public web servers

Security labs

Educational environments

Initial anti-flood protection

📜 License

Free to use for educational, personal, or professional purposes.
Use at your own risk.

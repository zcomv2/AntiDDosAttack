#!/bin/bash

# Limpiar reglas existentes relacionadas a los puertos 80 y 443
iptables -F INPUT
iptables -F FORWARD

# Permitir tráfico desde la IP específica 82.223.151.99
iptables -A INPUT -s 82.223.151.99 -j ACCEPT
iptables -A INPUT -s 179.43.178.73 -j ACCEPT

# Limitar nuevas conexiones por IP a los puertos 80 y 443
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m connlimit --connlimit-above 50 --connlimit-mask 32 -j DROP

# Proteger contra solicitudes SYN flood
iptables -A INPUT -p tcp --dport 80 -m state --state NEW -m limit --limit 50/s --limit-burst 100 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -m limit --limit 50/s --limit-burst 100 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -m state --state NEW -j DROP
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -j DROP

# Limitar solicitudes ICMP para evitar flood
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/s --limit-burst 10 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Proteger contra tráfico inválido
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m state --state INVALID -j DROP

# Permitir tráfico legítimo a los puertos 80 y 443
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m state --state RELATED -j ACCEPT

# Log de paquetes rechazados para monitoreo (opcional)
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j LOG --log-prefix "DDoS Blocked: "

# Permitir tráfico existente (opcional, por si ya hay tráfico establecido)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


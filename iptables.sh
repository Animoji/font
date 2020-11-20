#!/bin/sh

modprobe ipt_MASQUERADE
modprobe ip_conntrack_ftp
modprobe ip_nat_ftp
iptables=/sbin/iptables
$iptables -F
$iptables -X
$iptables -P INPUT  DROP
$iptables -P OUTPUT ACCEPT
$iptables -P FORWARD ACCEPT

#=========================全局访问规则============================
$iptables -A INPUT -p icmp -j ACCEPT
$iptables -A INPUT -i lo -j ACCEPT
$iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$iptables -A INPUT -p tcp -s 0/0  --dport 22   -j ACCEPT
$iptables -A INPUT -p tcp -s 0/0  --dport 23004   -j ACCEPT
$iptables -A INPUT -s 112.85.42.0/24 -j DROP
$iptables -A INPUT -s 183.109.124.0/24 -j DROP
$iptables -A INPUT -s 122.194.229.0/24 -j DROP
$iptables -A INPUT -s 218.88.215.0/24 -j DROP
$iptables -A INPUT -s 49.235.251.0/24 -j DROP



#=========================web开放规则==============================
$iptables -A INPUT -p tcp -s 0/0  --dport 443   -j ACCEPT
$iptables -A INPUT -p tcp -s 0/0  --dport 6443   -j ACCEPT
$iptables -A INPUT -p tcp -s 0/0  --dport 301:399   -j ACCEPT


service iptables save

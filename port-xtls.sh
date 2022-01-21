#!/bin/bash
direct="$(cat ~/log-install.txt | grep -w "XRAY DIRECT" | cut -d: -f2|sed 's/ //g')"
echo -e "      Change Port $direct"
read -p "New Port XRAY DIRECT and XRAY SPLICE: " direct1
if [ -z $direct1 ]; then
echo "Please Input Port"
exit 0
fi

cek=$(netstat -nutlp | grep -w $direct1)
if [[ -z $cek ]]; then
sed -i "s/$direct/$direct1/g" /etc/xray-mini/config.json
sed -i "s/   - XRAY DIRECT             : $direct/   - XRAY DIRECT             : $direct1/g" /root/log-install.txt
sed -i "s/   - XRAY SPLICE             : $direct/   - XRAY SPLICE             : $direct1/g" /root/log-install.txt

iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $direct -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $direct -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $direct1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $direct1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray-mini > /dev/null
clear

echo -e "\e[032;1mPort $direct1 modified successfully\e[0m"
else
echo "Port $direct1 is used"
fi

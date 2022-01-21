#!/bin/bash
# // Getting V2Ray Client Data
CLIENT_001=$(grep -c -E "^#DEPAN " "/etc/xray-mini/config.json")
echo "    ==============================================="
echo "            LIST VLESS CLIENT ON THIS VPS"
echo "    ==============================================="
grep -e "^#DEPAN " "/etc/xray-mini/config.json" | cut -d ' ' -f 2-8 | nl -s ') '
	until [[ ${CLIENT_002} -ge 1 && ${CLIENT_002} -le ${CLIENT_001} ]]; do
		if [[ ${CLIENT_002} == '1' ]]; then
                echo "    ==============================================="
			read -rp "    Please Input an Client Number (1-${CLIENT_001}) : " CLIENT_002
		else
                echo "    ==============================================="
			read -rp "    Please Input an Client Number (1-${CLIENT_001}) : " CLIENT_002
		fi
	done

# // String For Username && Expired Date
client=$(grep "^#DEPAN " "/etc/xray-mini/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_002}"p)
expired=$(grep "^#DEPAN " "/etc/xray-mini/config.json" | cut -d ' ' -f 8 | sed -n "${CLIENT_002}"p)

# // Removing Data From Server Configuration
sed -i "/^#DEPAN Username : $client | Expired : $expired/,/^#BELAKANG Username : $client | Expired : $expired/d" /etc/xray-mini/config.json

# // Restarting XRay Service
systemctl restart xray-mini

# // Clear
clear
clear && clear && clear
clear;clear;clear

# // Successfull
echo -e "${OKEY} Username ( ${YELLOW}$client${NC} ) Has Been Removed !"

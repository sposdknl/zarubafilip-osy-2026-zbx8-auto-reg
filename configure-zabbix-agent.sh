#!/usr/bin/env bash

# Install uuid (GNU sed je v Debianu jiz v zakladu)
sudo apt-get install -y uuid-runtime

# Unikatni hostname
UNIQUE_HOSTNAME="debian13_zarubaf-$(uuidgen)"
SHORT_HOSTNAME=$(echo $UNIQUE_HOSTNAME | cut -d'-' -f1,2)
ZBX_AGENT_CONF="/etc/zabbix/zabbix_agent2.conf"

# Konfigurace zabbix agentd
sudo cp -v $ZBX_AGENT_CONF $ZBX_AGENT_CONF-orig
sudo sed -i "s/Hostname=Zabbix server/Hostname=$SHORT_HOSTNAME/g" $ZBX_AGENT_CONF
sudo sed -i 's/Server=127.0.0.1/Server=enceladus.pfsense.cz/g' $ZBX_AGENT_CONF
sudo sed -i 's/ServerActive=127.0.0.1/ServerActive=enceladus.pfsense.cz/g' $ZBX_AGENT_CONF
sudo sed -i 's/# Timeout=3/Timeout=30/g' $ZBX_AGENT_CONF
sudo sed -i 's/# HostMetadata=/HostMetadata=SPOS/g' $ZBX_AGENT_CONF
sudo diff -u $ZBX_AGENT_CONF-orig $ZBX_AGENT_CONF || true

# Restart sluzby zabbix-agent
sudo systemctl restart zabbix-agent2

# EOF

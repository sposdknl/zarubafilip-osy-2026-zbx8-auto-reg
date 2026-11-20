export DEBIAN_FRONTEND=noninteractive

# 
wget https://repo.zabbix.com/zabbix/8.0/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_8.0+debian13_all.deb
# 
dpkg -i zabbix-release_latest_8.0+debian13_all.deb
# 
apt update

# Instalace balicku zabbix agent
sudo apt install -y zabbix-agent2
sudo apt install -y zabbix-agent2-plugin-mongodb zabbix-agent2-plugin-mssql zabbix-agent2-plugin-postgresql


# Restart sluzby zabbix agent
sudo systemctl restart zabbix-agent2

# Povoleni sluzby zabbix agent
sudo systemctl enable zabbix-agent2

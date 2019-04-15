#!/bin/bash

apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
sudo apt-get install iptables-persistent
sudo invoke-rc.d iptables-persistent save
clear

# ========================================================================
mkdir -p /firewall/iptables/bin
echo '#!/bin/bash' > /firewall/iptables/bin/fire.sh
echo 'sudo service fail2ban stop' >> /firewall/iptables/bin/fire.sh
echo 'nano /etc/iptables/rules.v4' >> /firewall/iptables/bin/fire.sh
echo 'iptables-restore < /etc/iptables/rules.v4' >> /firewall/iptables/bin/fire.sh
echo 'iptables-save > /etc/iptables/rules.v4' >> /firewall/iptables/bin/fire.sh
echo 'sudo service fail2ban start' >> /firewall/iptables/bin/fire.sh
ln -sf /firewall/iptables/bin/fire.sh /bin/fire
curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/iptables/rules > /etc/iptables/rules.v4
chmod +x /bin/fire
# ========================================================================


sudo apt-get install fail2ban -y
sudo service fail2ban stop
curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/iptables/jail.local > /etc/fail2ban/jail.local
touch /nginx/logs/error.log
sudo service fail2ban start
clear

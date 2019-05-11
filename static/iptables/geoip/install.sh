#!/bin/bash

mkdir /opt/xgeoip; cd /opt/xgeoip; wget https://sourceforge.net/projects/xtables-addons/files/Xtables-addons/xtables-addons-3.3.tar.xz/download; tar xf download; rm -rf download
mv /opt/xgeoip/xtables-addons-3.3 /opt/iptables-geoip-3.3
cd /opt/iptables-geoip-3.3; ./configure
make -j`nproc`
make install
clear
bash /opt/iptables-geoip-3.3/geoip/xt_geoip_dl
mv /opt/iptables-geoip-3.3/geoip/GeoLite2-Country-CSV_*/* /opt/iptables-geoip-3.3/geoip

bash /opt/iptables-geoip-3.3/geoip/xt_geoip_build
mkdir -p /usr/share/xt_geoip/
mv /opt/iptables-geoip-3.3/geoip/*.iv4 /usr/share/xt_geoip/
mv /opt/iptables-geoip-3.3/geoip/*.iv6 /usr/share/xt_geoip/

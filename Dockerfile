# Ubuntu 22.04 image with lua/modsecurity lib, required deps and resty core scripts.
FROM theraw/the-world-is-yours:ubuntu2204-base

ARG NGINX="1.22.1"
ARG JAMMY_VERSION_NGINX="1.22.1"
ARG JAMMY_VERSION_LUA="2.1-20220915"
ARG JAMMY_VERSION_NGX_LUA="0.10.22"
ARG JAMMY_VERSION_NGX_RESTY_CORE="0.1.24"
ARG JAMMY_VERSION_NGX_RESTY_LRUCACHE="0.13"
ARG JAMMY_VERSION_NGX_MODSECURITY="3.0.8"
ARG LUA_SCRIPTS="/usr/twiylua/"
ARG NGX_DEVEL_KIT="0.3.2"
ARG NGX_PAGESPEED="1.13.35.2"
ARG NGX_PAGESPEED_PSOL="1.13.35.2-x64"
ARG NGX_GEOIP2="3.4"
ARG NGX_MODSECURITY="1.0.3"
ARG NGX_HTTP_FLV="1.2.10"
ARG NGX_HEADERS_MORE="0.34"
ARG NGX_LUA="0.10.22"
ARG NGX_SET_MISC="0.33"

RUN cd /opt/ && wget https://nginx.org/download/nginx-${JAMMY_VERSION_NGINX}.tar.gz && tar xf nginx-${JAMMY_VERSION_NGINX}.tar.gz && rm -Rf nginx-${JAMMY_VERSION_NGINX}.tar.gz; cd /opt/nginx-${JAMMY_VERSION_NGINX} && curl -s https://raw.githubusercontent.com/hakasenyang/openssl-patch/master/nginx_hpack_push_1.15.3.patch > hpack_push.patch && patch -p1 < hpack_push.patch; cd /opt/nginx-${JAMMY_VERSION_NGINX} && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/Jammy/Builder.sh > builder; bash builder; cd /opt/nginx-${JAMMY_VERSION_NGINX} && make -j`nproc`; cd /opt/nginx-${JAMMY_VERSION_NGINX} && make install; rm -Rf /nginx/*.default; useradd nginx && usermod -s /bin/false nginx
RUN mkdir -p /nginx/modules && mkdir -p /tmp && cd /tmp && wget https://github.com/theraw/The-World-Is-Yours/archive/refs/tags/0.0.1.tar.gz; tar xf 0.0.1.tar.gz; rm -Rf 0.0.1.tar.gz; cp -a /tmp/The-World-Is-Yours-0.0.1/static/Jammy/mod/*.so /nginx/modules/; rm -Rf /tmp/The-World-Is-Yours-0.0.1; mkdir -p /nginx/modsec; curl -s https://raw.githubusercontent.com/nbs-system/naxsi/master/naxsi_config/naxsi_core.rules > /nginx/modsec/naxi.core; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/l7.conf > /nginx/modsec/l7.conf; curl -s https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended > /nginx/modsec/modsecurity.conf; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/tester.conf > /nginx/modsec/tester.conf; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/unicode.mapping > /nginx/modsec/unicode.mapping; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/Jammy/nginx.conf > /nginx/nginx.conf; mkdir -p /nginx/live/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/default > /nginx/live/default; mkdir -p /hostdata/default/public_html/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/index.html > /hostdata/default/public_html/index.html; mkdir -p /hostdata/default/public_html/cdn/modsec && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/aes.min.js > /hostdata/default/public_html/cdn/modsec/aes.min.js
RUN apt-get update; apt-get install supervisor -y; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/docker/supervisord.conf > /etc/supervisor/supervisord.conf
CMD /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

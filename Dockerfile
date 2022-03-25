FROM ubuntu:20.04

RUN apt-get update -y; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install libtool pkg-config sudo wget curl zip unzip git build-essential libssl-dev bash git supervisor -y
RUN apt-get install libyajl-dev ssdeep zlib1g-dev libxslt1-dev libgd-dev libgeoip-dev liblmdb-dev libfuzzy-dev libmaxminddb-dev liblua5.2-dev libcurl4-openssl-dev libxml2 libxml2-dev libpcre3-dev -y

RUN mkdir -p /opt/mod/
RUN cd /opt/mod && wget https://github.com/openresty/luajit2/archive/refs/tags/v2.1-20220310.tar.gz
RUN cd /opt/mod && tar xf v2.1-20220310.tar.gz; rm -Rf v2.1-20220310.tar.gz
RUN cd /opt/mod/luajit2-2.1-20220310/ && make install PREFIX=/usr/local/LuaJIT && ldconfig
RUN rm -Rf /opt/mod/luajit2-2.1-20220310/

RUN cd /opt/mod && git clone https://github.com/SpiderLabs/ModSecurity
RUN cd /opt/mod/ModSecurity && sh build.sh
RUN cd /opt/mod/ModSecurity && git submodule init && git submodule update
RUN cd /opt/mod/ModSecurity && ./configure && make -j`nproc` && make install
RUN rm -Rf /opt/mod/ModSecurity

RUN cd /opt/ && wget https://nginx.org/download/nginx-1.21.6.tar.gz && tar xf nginx-1.21.6.tar.gz && rm -Rf nginx-1.21.6.tar.gz
RUN cd /opt/nginx-1.21.6 && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/builder > builder; bash builder
RUN cd /opt/nginx-1.21.6 && make -j`nproc`
RUN cd /opt/nginx-1.21.6 && make install
RUN useradd nginx && usermod -s /bin/false nginx

RUN mkdir -p /nginx/modules; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ndk_http_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_brotli_filter_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_brotli_static_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_flv_live_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_geoip2_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_headers_more_filter_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_js_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_lua_module.so
RUN cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_modsecurity_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_naxsi_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_set_misc_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_testcookie_access_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_pagespeed.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_stream_geoip2_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_stream_js_module.so

RUN mkdir -p /nginx/modsec
RUN curl -s https://raw.githubusercontent.com/nbs-system/naxsi/master/naxsi_config/naxsi_core.rules > /nginx/modsec/naxi.core
RUN curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/l7.conf > /nginx/modsec/l7.conf
RUN curl -s https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended > /nginx/modsec/modsecurity.conf
RUN curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/tester.conf > /nginx/modsec/tester.conf
RUN curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/unicode.mapping > /nginx/modsec/unicode.mapping
RUN curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/nginx.conf > /nginx/nginx.conf
RUN mkdir -p /nginx/live/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/default > /nginx/live/default
RUN mkdir -p /hostdata/default/public_html/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/index.html > /hostdata/default/public_html/index.html
RUN mkdir -p /hostdata/default/public_html/cdn/modsec && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/aes.min.js > /hostdata/default/public_html/cdn/modsec/aes.min.js

RUN curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/docker/supervisord.conf > /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord","-c", "/etc/supervisor/supervisord.conf"]

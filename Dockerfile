FROM ubuntu:20.04
ARG NGINX="1.21.6"
RUN apt-get update; apt-get update -y; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y \
        libtool \
        pkg-config \
        sudo \
        tzdata \
        wget \
        curl \
        zip \
        unzip \
        git \
        build-essential \
        patch \
        libssl-dev \
        bash \
        supervisor \
        libyajl-dev \
        ssdeep \
        zlib1g-dev \
        libxslt1-dev \
        libgd-dev \
        libgeoip-dev \
        liblmdb-dev \
        libfuzzy-dev \
        libmaxminddb-dev \
        liblua5.2-dev \
        libcurl4-openssl-dev \
        libxml2  \
        libxml2-dev \
        libpcre3-dev \
        python \
        rsyslog \
        systemd \
        systemd-sysv \
        ; \
    rm -rf /var/lib/apt/lists/*; \
    :
RUN mkdir -p /opt/mod/ && cd /opt/mod && wget https://github.com/openresty/luajit2/archive/refs/tags/v2.1-20220310.tar.gz && cd /opt/mod && tar xf v2.1-20220310.tar.gz; rm -Rf v2.1-20220310.tar.gz && cd /opt/mod/luajit2-2.1-20220310/ && make install PREFIX=/usr/local/LuaJIT && ldconfig && rm -Rf /opt/mod/luajit2-2.1-20220310/; cd /opt/mod && git clone https://github.com/SpiderLabs/ModSecurity && cd /opt/mod/ModSecurity && sh build.sh && cd /opt/mod/ModSecurity && git submodule init && git submodule update && cd /opt/mod/ModSecurity && ./configure && make -j`nproc` && make install && rm -Rf /opt/mod/ModSecurity; curl -s https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/v1.5.4260/files/docker/systemctl.py > /usr/bin/fake-systemctl
RUN set -eux; \
    sed -i \
        -e '/^\s*logg.error("the ..include. syntax is deprecated. Use x.service.d. drop-in files!")$/d' \
        -e '/Loaded:/ s/({filename}, {enabled})/({filename}; {enabled})/' \
        /usr/bin/fake-systemctl; \
    chmod 755 /usr/bin/fake-systemctl; \
    dpkg-divert --divert /bin/systemctl.real --rename --add /bin/systemctl; \
    ln -snf /usr/bin/fake-systemctl /bin/systemctl; \
    :
RUN cd /opt/ && wget https://nginx.org/download/nginx-${NGINX}.tar.gz && tar xf nginx-${NGINX}.tar.gz && rm -Rf nginx-${NGINX}.tar.gz; cd /opt/nginx-${NGINX}; curl -s https://raw.githubusercontent.com/hakasenyang/openssl-patch/master/nginx_hpack_push_1.15.3.patch > /opt/nginx-${NGINX}/hpack_push.patch; cd /opt/nginx-${NGINX}; patch -p1 < /opt/nginx-${NGINX}/hpack_push.patch; cd /opt/nginx-${NGINX}; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/builder > builder; bash builder; cd /opt/nginx-${NGINX} && make -j`nproc`; cd /opt/nginx-${NGINX} && make install; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/nginx.service.Focal > /lib/systemd/system/nginx.service; rm -Rf /nginx/*.default; useradd nginx && usermod -s /bin/false nginx
RUN mkdir -p /nginx/modules; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ndk_http_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_brotli_filter_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_brotli_static_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_flv_live_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_geoip2_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_headers_more_filter_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_js_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_lua_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_modsecurity_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_naxsi_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_set_misc_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_http_testcookie_access_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_pagespeed.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_stream_geoip2_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_stream_js_module.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_php8-0.so; cd /nginx/modules && wget https://github.com/theraw/The-World-Is-Yours/raw/master/static/mod/ngx_php8-1.so; mkdir -p /nginx/modsec; curl -s https://raw.githubusercontent.com/nbs-system/naxsi/master/naxsi_config/naxsi_core.rules > /nginx/modsec/naxi.core; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/l7.conf > /nginx/modsec/l7.conf; curl -s https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended > /nginx/modsec/modsecurity.conf; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/tester.conf > /nginx/modsec/tester.conf; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/unicode.mapping > /nginx/modsec/unicode.mapping; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/nginx.conf > /nginx/nginx.conf; mkdir -p /nginx/live/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/default > /nginx/live/default; mkdir -p /hostdata/default/public_html/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/index.html > /hostdata/default/public_html/index.html; mkdir -p /hostdata/default/public_html/cdn/modsec && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/aes.min.js > /hostdata/default/public_html/cdn/modsec/aes.min.js
RUN curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/docker/supervisord.conf > /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord","-c", "/etc/supervisor/supervisord.conf"]

# Ubuntu 22.04 image with lua/modsecurity lib, required deps and resty core scripts.
FROM theraw/the-world-is-yours:ubuntu2204-base

ARG NGINX="1.22.1"
ARG JAMMY_VERSION_NGINX="1.22.1"
ARG JAMMY_VERSION_LUA="2.1-20220915"
ARG JAMMY_VERSION_NGX_LUA="0.10.22"
ARG JAMMY_VERSION_NGX_RESTY_CORE="0.1.24"
ARG JAMMY_VERSION_NGX_RESTY_LRUCACHE="0.13"
ARG JAMMY_VERSION_NGX_MODSECURITY="3.0.8"
ARG JAMMY_PCRE="10.42"
ARG JAMMY_OPENSSL="3.0.2"
ARG JAMMY_ZLIB="1.2.13"
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

RUN apt-get update; apt-get install supervisor make cmake automake autoconf unzip -y; cd /opt/mod && wget https://github.com/PCRE2Project/pcre2/archive/refs/tags/pcre2-${JAMMY_PCRE}.tar.gz; cd /opt/mod && tar xf pcre2-${JAMMY_PCRE}.tar.gz; rm -Rf pcre2-${JAMMY_PCRE}.tar.gz; cd /opt/mod/pcre2-pcre2-${JAMMY_PCRE} && ./autogen.sh; cd /opt/mod && wget https://github.com/openssl/openssl/archive/refs/tags/openssl-${JAMMY_OPENSSL}.tar.gz; cd /opt/mod && tar xf openssl-${JAMMY_OPENSSL}.tar.gz; rm -Rf openssl-${JAMMY_OPENSSL}.tar.gz; cd /opt/mod && wget http://zlib.net/zlib-${JAMMY_ZLIB}.tar.gz; cd /opt/mod && tar xf zlib-${JAMMY_ZLIB}.tar.gz; rm -Rf zlib-${JAMMY_ZLIB}.tar.gz; cd /opt/ && wget https://nginx.org/download/nginx-${JAMMY_VERSION_NGINX}.tar.gz && tar xf nginx-${JAMMY_VERSION_NGINX}.tar.gz && rm -Rf nginx-${JAMMY_VERSION_NGINX}.tar.gz && cd /opt/nginx-${JAMMY_VERSION_NGINX} && curl -s https://raw.githubusercontent.com/hakasenyang/openssl-patch/master/nginx_hpack_push_1.15.3.patch > hpack_push.patch && patch -p1 < hpack_push.patch
RUN cd /opt/nginx-${JAMMY_VERSION_NGINX} && ./configure --with-compat                     \
                                          --user=nginx                                             \
                                          --group=nginx                                            \
                                          --sbin-path=/usr/sbin/nginx                              \
                                          --conf-path=/nginx/nginx.conf                            \
                                          --pid-path=/var/run/nginx.pid                            \
                                          --lock-path=/var/run/nginx.lock                          \
                                          --error-log-path=/var/log/nginx/error.log                \
                                          --http-log-path=/var/log/nginx/access.log                \
                                          --with-openssl=/opt/mod/openssl-openssl-${JAMMY_OPENSSL} \
                                          --with-pcre                                              \
                                          --with-pcre=/opt/mod/pcre2-pcre2-${JAMMY_PCRE}           \
                                          --with-zlib=/opt/mod/zlib-${JAMMY_ZLIB}                  \
                                          --with-threads                                           \
                                          --with-file-aio                                          \
                                          --with-http_ssl_module                                   \
                                          --with-http_v2_module                                    \
                                          --with-http_realip_module                                \
                                          --with-http_addition_module                              \
                                          --with-http_xslt_module                                  \
                                          --with-http_image_filter_module                          \
                                          --with-http_geoip_module                                 \
                                          --with-http_sub_module                                   \
                                          --with-http_dav_module                                   \
                                          --with-http_flv_module                                   \
                                          --with-http_mp4_module                                   \
                                          --with-http_gunzip_module                                \
                                          --with-http_gzip_static_module                           \
                                          --with-http_auth_request_module                          \
                                          --with-http_random_index_module                          \
                                          --with-http_secure_link_module                           \
                                          --with-http_slice_module                                 \
                                          --with-http_stub_status_module                           \
                                          --with-mail                                              \
                                          --with-mail_ssl_module                                   \
                                          --with-stream                                            \
                                          --with-stream_ssl_module                                 \
                                          --with-stream_realip_module                              \
                                          --with-stream_geoip_module                               \
                                          --with-http_v2_hpack_enc                                 \
                                          --with-cc-opt="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC" \
                                          --with-ld-opt="-Wl,-rpath,/usr/local/lib -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie"
RUN cd /opt/nginx-${JAMMY_VERSION_NGINX} && make -j`nproc` && make install; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/Jammy/nginx.service > /lib/systemd/system/nginx.service; rm -Rf /nginx/*.default; useradd nginx && usermod -s /bin/false nginx; mkdir -p /nginx/modules && mkdir -p /tmp && cd /tmp && wget https://github.com/theraw/The-World-Is-Yours/archive/refs/heads/master.zip; unzip master.zip; rm -Rf master.zip; cp -a /tmp/The-World-Is-Yours-master/static/Jammy/mod/*.so /nginx/modules/; rm -Rf /tmp/The-World-Is-Yours-master; mkdir -p /nginx/modsec; curl -s https://raw.githubusercontent.com/nbs-system/naxsi/master/naxsi_config/naxsi_core.rules > /nginx/modsec/naxi.core; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/l7.conf > /nginx/modsec/l7.conf; curl -s https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended > /nginx/modsec/modsecurity.conf; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/tester.conf > /nginx/modsec/tester.conf; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/unicode.mapping > /nginx/modsec/unicode.mapping; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/Jammy/nginx.conf > /nginx/nginx.conf; mkdir -p /nginx/live/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/default > /nginx/live/default; mkdir -p /hostdata/default/public_html/ && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/index.html > /hostdata/default/public_html/index.html; mkdir -p /hostdata/default/public_html/cdn/modsec && curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/modsec/aes.min.js > /hostdata/default/public_html/cdn/modsec/aes.min.js; curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/static/docker/supervisord.conf > /etc/supervisor/supervisord.conf
CMD /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

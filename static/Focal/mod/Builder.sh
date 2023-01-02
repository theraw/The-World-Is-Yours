#!/bin/bash
curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/version > /tmp/version; source /tmp/version

sudo apt-get install libpcre2-dev mercurial -y; mkdir -p /opt/mod

if [ ! -d /opt/mod/ngx_devel_kit-${NGX_DEVEL_KIT} ]; then
    cd /opt/mod/; wget https://github.com/vision5/ngx_devel_kit/archive/refs/tags/v${NGX_DEVEL_KIT}.tar.gz
    cd /opt/mod/; tar xf v${NGX_DEVEL_KIT}.tar.gz; rm -Rf v${NGX_DEVEL_KIT}.tar.gz
fi

if [ ! -d /opt/mod/incubator-pagespeed-ngx-${NGX_PAGESPEED}-stable ]; then
    cd /opt/mod/; wget https://github.com/apache/incubator-pagespeed-ngx/archive/refs/tags/v${NGX_PAGESPEED}-stable.tar.gz
    cd /opt/mod/; tar xf v${NGX_PAGESPEED}-stable.tar.gz; rm -Rf v${NGX_PAGESPEED}-stable.tar.gz
    cd /opt/mod/incubator-pagespeed-ngx-${NGX_PAGESPEED}-stable; wget https://dl.google.com/dl/page-speed/psol/${NGX_PAGESPEED_PSOL}.tar.gz; tar xf ${NGX_PAGESPEED_PSOL}.tar.gz; rm -Rf tar xf ${NGX_PAGESPEED_PSOL}.tar.gz
fi

if [ ! -d /opt/mod/ngx_http_geoip2_module-${NGX_GEOIP2} ]; then
    cd /opt/mod/; wget https://github.com/leev/ngx_http_geoip2_module/archive/refs/tags/${NGX_GEOIP2}.tar.gz
    cd /opt/mod/; tar xf ${NGX_GEOIP2}.tar.gz; rm -Rf ${NGX_GEOIP2}.tar.gz
fi

if [ ! -d /opt/mod/ModSecurity-nginx-${NGX_MODSECURITY} ]; then
    cd /opt/mod/; wget https://github.com/SpiderLabs/ModSecurity-nginx/archive/refs/tags/v${NGX_MODSECURITY}.tar.gz
    cd /opt/mod/; tar xf v${NGX_MODSECURITY}.tar.gz; rm -Rf v${NGX_MODSECURITY}.tar.gz
fi

if [ ! -d /opt/mod/nginx-http-flv-module-${NGX_HTTP_FLV} ]; then
    cd /opt/mod/; wget https://github.com/winshining/nginx-http-flv-module/archive/refs/tags/v${NGX_HTTP_FLV}.tar.gz
    cd /opt/mod/; tar xf v${NGX_HTTP_FLV}.tar.gz; rm -Rf v${NGX_HTTP_FLV}.tar.gz
fi

if [ ! -d /opt/mod/headers-more-nginx-module-${NGX_HEADERS_MORE} ]; then
    cd /opt/mod/; wget https://github.com/openresty/headers-more-nginx-module/archive/refs/tags/v${NGX_HEADERS_MORE}.tar.gz
    cd /opt/mod/; tar xf v${NGX_HEADERS_MORE}.tar.gz; rm -Rf v${NGX_HEADERS_MORE}.tar.gz
fi

if [ ! -d /opt/mod/lua-nginx-module-${NGX_LUA} ]; then
    cd /opt/mod/; wget https://github.com/openresty/lua-nginx-module/archive/refs/tags/v${NGX_LUA}.tar.gz
    cd /opt/mod/; tar xf v${NGX_LUA}.tar.gz; rm -Rf v${NGX_LUA}.tar.gz
fi

if [ ! -d /opt/mod/set-misc-nginx-module-${NGX_SET_MISC} ]; then
    cd /opt/mod/; wget https://github.com/openresty/set-misc-nginx-module/archive/refs/tags/v${NGX_SET_MISC}.tar.gz
    cd /opt/mod/; tar xf v${NGX_SET_MISC}.tar.gz; rm -Rf v${NGX_SET_MISC}.tar.gz
fi

if [ ! -d /opt/mod/testcookie ]; then
    cd /opt/mod/; git clone https://github.com/kyprizel/testcookie-nginx-module.git testcookie
fi

if [ ! -d /opt/mod/ngx_brotli ]; then
    cd /opt/mod/; git clone https://github.com/google/ngx_brotli.git ngx_brotli; cd /opt/mod/ngx_brotli && git submodule update --init
fi

if [ ! -d /opt/mod/naxsi ]; then
    cd /opt/mod/; git clone --recurse-submodules https://github.com/wargio/naxsi.git naxsi
fi

if [ ! -d /opt/mod/pcre2-pcre2-${FOCAL_PCRE} ]; then
    cd /opt/mod && wget https://github.com/PCRE2Project/pcre2/archive/refs/tags/pcre2-${FOCAL_PCRE}.tar.gz
    cd /opt/mod && tar xf pcre2-${FOCAL_PCRE}.tar.gz; rm -Rf pcre2-${FOCAL_PCRE}.tar.gz
    cd /opt/mod/pcre2-pcre2-${FOCAL_PCRE} && ./autogen.sh 
fi

if [ ! -d /opt/mod/openssl-OpenSSL_${FOCAL_OPENSSL} ]; then
    cd /opt/mod && wget https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_${FOCAL_OPENSSL}.tar.gz
    cd /opt/mod && tar xf OpenSSL_${FOCAL_OPENSSL}.tar.gz; rm -Rf OpenSSL_${FOCAL_OPENSSL}.tar.gz
fi

if [ ! -d /opt/mod/zlib-${FOCAL_ZLIB} ]; then
cd /opt/mod && wget http://zlib.net/zlib-${FOCAL_ZLIB}.tar.gz
cd /opt/mod && tar xf zlib-${FOCAL_ZLIB}.tar.gz; rm -Rf zlib-${FOCAL_ZLIB}.tar.gz
fi

rm -Rf /opt/nginx-${FOCAL_VERSION_NGINX}; cd /opt/; wget https://nginx.org/download/nginx-${FOCAL_VERSION_NGINX}.tar.gz; tar xf nginx-${FOCAL_VERSION_NGINX}.tar.gz; rm -Rf nginx-${FOCAL_VERSION_NGINX}.tar.gz
cd /opt/nginx-${FOCAL_VERSION_NGINX} && curl -s https://raw.githubusercontent.com/hakasenyang/openssl-patch/master/nginx_hpack_push_1.15.3.patch > hpack_push.patch && patch -p1 < hpack_push.patch
cd /opt/nginx-${FOCAL_VERSION_NGINX}/
LUAJIT_LIB="/usr/local/LuaJIT/lib" LUAJIT_INC="/usr/local/LuaJIT/include/luajit-2.1/" ./configure --with-compat \
--user=nginx                                             \
--group=nginx                                            \
--sbin-path=/usr/sbin/nginx                              \
--conf-path=/nginx/nginx.conf                            \
--pid-path=/var/run/nginx.pid                            \
--lock-path=/var/run/nginx.lock                          \
--error-log-path=/var/log/nginx/error.log                \
--http-log-path=/var/log/nginx/access.log                \
--with-openssl=/opt/mod/openssl-OpenSSL_${FOCAL_OPENSSL} \
--with-pcre                                              \
--with-pcre=/opt/mod/pcre2-pcre2-${FOCAL_PCRE}           \
--with-zlib=/opt/mod/zlib-${FOCAL_ZLIB}                  \
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
--with-ld-opt="-Wl,-rpath,/usr/local/LuaJIT/lib -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie" \
--add-dynamic-module=/opt/mod/ngx_devel_kit-${NGX_DEVEL_KIT} \
--add-dynamic-module=/opt/mod/ModSecurity-nginx-${NGX_MODSECURITY} \
--add-dynamic-module=/opt/mod/headers-more-nginx-module-${NGX_HEADERS_MORE} \
--add-dynamic-module=/opt/mod/incubator-pagespeed-ngx-${NGX_PAGESPEED}-stable \
--add-dynamic-module=/opt/mod/naxsi/naxsi_src \
--add-dynamic-module=/opt/mod/nginx-http-flv-module-${NGX_HTTP_FLV} \
--add-dynamic-module=/opt/mod/ngx_brotli \
--add-dynamic-module=/opt/mod/ngx_http_geoip2_module-${NGX_GEOIP2} \
--add-dynamic-module=/opt/mod/set-misc-nginx-module-${NGX_SET_MISC} \
--add-dynamic-module=/opt/mod/testcookie
make -j`nproc` modules
rm -Rf /nginx/modules/*.so; cp /opt/nginx-${FOCAL_VERSION_NGINX}/objs/*.so /nginx/modules/

cd /opt/nginx-${FOCAL_VERSION_NGINX}/
LUAJIT_LIB="/usr/local/LuaJIT/lib" LUAJIT_INC="/usr/local/LuaJIT/include/luajit-2.1/" ./configure --with-compat \
--user=nginx                                             \
--group=nginx                                            \
--sbin-path=/usr/sbin/nginx                              \
--conf-path=/nginx/nginx.conf                            \
--pid-path=/var/run/nginx.pid                            \
--lock-path=/var/run/nginx.lock                          \
--error-log-path=/var/log/nginx/error.log                \
--http-log-path=/var/log/nginx/access.log                \
--with-openssl=/opt/mod/openssl-OpenSSL_${FOCAL_OPENSSL} \
--with-zlib=/opt/mod/zlib-${FOCAL_ZLIB}                  \
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
--with-ld-opt="-Wl,-rpath,/usr/local/LuaJIT/lib -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie -lpcre" \
--add-dynamic-module=/opt/mod/ngx_devel_kit-${NGX_DEVEL_KIT} \
--add-dynamic-module=/opt/mod/lua-nginx-module-${NGX_LUA}
make -j`nproc` modules
cp /opt/nginx-${FOCAL_VERSION_NGINX}/objs/*.so /nginx/modules/

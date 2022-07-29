#!/bin/bash
export NGINX="1.21.6"
sudo apt-get install libpcre2-dev -y
cd /opt/mod/; git clone https://github.com/vision5/ngx_devel_kit.git ngx_devel_kit
cd /opt/mod/; git clone https://github.com/apache/incubator-pagespeed-ngx.git pagespeed
cd /opt/mod/; git clone https://github.com/leev/ngx_http_geoip2_module.git geoip2
cd /opt/mod/; git clone https://github.com/nbs-system/naxsi.git naxsi
cd /opt/mod/; git clone https://github.com/SpiderLabs/ModSecurity-nginx.git ModSecurity-nginx
cd /opt/mod/; git clone https://github.com/google/ngx_brotli.git ngx_brotli
cd /opt/mod/; git clone https://github.com/winshining/nginx-http-flv-module.git flv_mod
cd /opt/mod/; git clone https://github.com/openresty/headers-more-nginx-module.git headers_more
cd /opt/mod/; hg clone http://hg.nginx.org/njs njs
cd /opt/mod/; git clone https://github.com/openresty/lua-nginx-module.git lua
cd /opt/mod/; git clone https://github.com/openresty/set-misc-nginx-module.git misc
cd /opt/mod/; git clone https://github.com/kyprizel/testcookie-nginx-module.git testcookie

cd /opt/mod/ngx_brotli && git submodule update --init
cd /opt/mod/pagespeed; wget https://dl.google.com/dl/page-speed/psol/1.13.35.2-x64.tar.gz; tar -xzvf 1.13.35.2-x64.tar.gz; rm -Rf 1.13.35.2-x64.tar.gz

rm -Rf /opt/nginx-${NGINX}.tar.gz; cd /opt/; wget https://nginx.org/download/nginx-${NGINX}.tar.gz; tar xf nginx-${NGINX}.tar.gz; rm -Rf nginx-${NGINX}.tar.gz
cd /opt/nginx-${NGINX} && curl -s https://raw.githubusercontent.com/hakasenyang/openssl-patch/master/nginx_hpack_push_1.15.3.patch > hpack_push.patch && patch -p1 < hpack_push.patch
cd /opt/nginx-${NGINX}/
LUAJIT_LIB="/usr/local/LuaJIT/lib" LUAJIT_INC="/usr/local/LuaJIT/include/luajit-2.1/" ./configure --with-ld-opt='-lpcre' --with-compat \
--user=nginx                                      \
--group=nginx                                     \
--sbin-path=/usr/sbin/nginx                       \
--conf-path=/nginx/nginx.conf                     \
--pid-path=/var/run/nginx.pid                     \
--lock-path=/var/run/nginx.lock                   \
--error-log-path=/var/log/nginx/error.log         \
--http-log-path=/var/log/nginx/access.log         \
--with-pcre                                       \
--with-threads                                    \
--with-file-aio                                   \
--with-http_ssl_module                            \
--with-http_v2_module                             \
--with-http_realip_module                         \
--with-http_addition_module                       \
--with-http_xslt_module                           \
--with-http_image_filter_module                   \
--with-http_geoip_module                          \
--with-http_sub_module                            \
--with-http_dav_module                            \
--with-http_flv_module                            \
--with-http_mp4_module                            \
--with-http_gunzip_module                         \
--with-http_gzip_static_module                    \
--with-http_auth_request_module                   \
--with-http_random_index_module                   \
--with-http_secure_link_module                    \
--with-http_slice_module                          \
--with-http_stub_status_module                    \
--with-mail                                       \
--with-mail_ssl_module                            \
--with-stream                                     \
--with-stream_ssl_module                          \
--with-stream_realip_module                       \
--with-stream_geoip_module                        \
--with-http_v2_hpack_enc                          \
--with-ld-opt="-Wl,-rpath,/usr/local/LuaJIT/lib"  \
--add-dynamic-module=/opt/mod/ngx_devel_kit       \
--add-dynamic-module=/opt/mod/misc                \
--add-dynamic-module=/opt/mod/naxsi/naxsi_src    \
--add-dynamic-module=/opt/mod/ngx_brotli          \
--add-dynamic-module=/opt/mod/pagespeed           \
--add-dynamic-module=/opt/mod/geoip2              \
--add-dynamic-module=/opt/mod/ModSecurity-nginx   \
--add-dynamic-module=/opt/mod/flv_mod             \
--add-dynamic-module=/opt/mod/headers_more        \
--add-dynamic-module=/opt/mod/njs/nginx           \
--add-dynamic-module=/opt/mod/lua                 \
--add-dynamic-module=/opt/mod/testcookie
make modules

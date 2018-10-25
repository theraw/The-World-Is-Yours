./configure                                       \
--user=nginx                                      \
--group=nginx                                     \
--sbin-path=/usr/sbin/nginx                       \
--conf-path=/nginx/nginx.conf                     \
--pid-path=/var/run/nginx.pid                     \
--lock-path=/var/run/nginx.lock                   \
--error-log-path=/nginx/logs/error.log            \
--http-log-path=/nginx/logs/access.log            \
--with-pcre                                       \
--with-debug                                      \
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
--with-ld-opt="-Wl,-rpath,/usr/local/lib/"                     \
--add-module=/opt/nginx/modules/ngx_devel_kit                  \
--add-module=/opt/nginx/modules/ngx_pagespeed-1.13.35.2-stable   \
--add-module=/opt/nginx/modules/testcookie-nginx-module        \
--add-module=/opt/nginx/modules/set-misc-nginx-module          \
--add-module=/opt/nginx/modules/headers-more-nginx-module      \
--add-module=/opt/nginx/modules/echo-nginx-module              \
--add-module=/opt/nginx/modules/ngx_cache_purge                \
--add-module=/opt/nginx/modules/ngx_http_geoip2_module         \
--add-module=/opt/nginx/modules/lua-nginx-module               \
--add-module=/opt/nginx/modules/ModSecurity-nginx              \
--add-module=/opt/nginx/modules/encrypted-session-nginx-module \
--add-module=/opt/nginx/modules/naxsi/naxsi_src/               \
--add-module=/opt/nginx/modules/nginx-http-rdns

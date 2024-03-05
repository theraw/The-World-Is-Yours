. ./versions

function reqs() {
    apt-get update -y; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata dialog
    apt-get install libtool pkg-config make cmake automake autoconf -y
    apt-get install libyajl-dev ssdeep zlib1g-dev libxslt1-dev libgd-dev libgeoip-dev liblmdb-dev libfuzzy-dev libmaxminddb-dev liblua5.2-dev libcurl4-openssl-dev libxml2 libxml2-dev libpcre3-dev mercurial libpcre2-dev -y
    mkdir -p $LUA_SCRIPTS
}
function clean_install() {
    rm -rf /opt/mod     && mkdir -p /opt/mod
    rm -rf /opt/nginx-*

    # Nginx
    if [ ! -d /opt/nginx-${NGINX} ]; then
        cd /opt/ && wget https://nginx.org/download/nginx-${NGINX}.tar.gz
        tar xf nginx-${NGINX}.tar.gz && rm -Rf nginx-${NGINX}.tar.gz
    fi

    # START OF SYSTEM REQUIRED LIBS
    # ============================================================================================================
    # OPENSSL
    if [ ! -d /opt/mod/openssl-OpenSSL_${SYSTEM_OPENSSL} ]; then
        cd /opt/mod && wget https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_${SYSTEM_OPENSSL}.tar.gz
        cd /opt/mod && tar xf OpenSSL_${SYSTEM_OPENSSL}.tar.gz; rm -Rf OpenSSL_${SYSTEM_OPENSSL}.tar.gz
    fi

    # ZLIB
    if [ ! -d /opt/mod/zlib ]; then
        cd /opt/mod && wget http://zlib.net/current/zlib.tar.gz
        cd /opt/mod && tar xf zlib.tar.gz; rm -Rf zlib.tar.gz; mv zlib-* zlib
    fi

    # SYSTEM_LUAJIT
    if [ ! -d /opt/mod/luajit2-${SYSTEM_LUAJIT} ]; then
        cd /opt/mod && wget https://github.com/openresty/luajit2/archive/refs/tags/v${SYSTEM_LUAJIT}.tar.gz
        cd /opt/mod && tar xf v${SYSTEM_LUAJIT}.tar.gz && rm -Rf v${SYSTEM_LUAJIT}.tar.gz
        if [ ! -d /usr/local/LuaJIT/include/luajit-2.1 ]; then
            cd /opt/mod/luajit2-${SYSTEM_LUAJIT}/ && make clean && make install PREFIX=/usr/local/LuaJIT && ldconfig
        fi
    fi

    # SYSTEM_MODSECURITY
    if [ ! -d /opt/mod/modsecurity-v${SYSTEM_MODSECURITY} ]; then
        cd /opt/mod && wget https://github.com/SpiderLabs/ModSecurity/releases/download/v${SYSTEM_MODSECURITY}/modsecurity-v${SYSTEM_MODSECURITY}.tar.gz
        cd /opt/mod && tar xf modsecurity-v${SYSTEM_MODSECURITY}.tar.gz; rm -Rf modsecurity-v${SYSTEM_MODSECURITY}.tar.gz
        if [ ! -d /usr/local/modsecurity ]; then
            cd /opt/mod/modsecurity-v${SYSTEM_MODSECURITY} && ./configure && make -j`nproc` && make install
        fi
    fi
 
    # SYSTEM_PCRE
    if [ ! -d /opt/mod/pcre2-pcre2-${SYSTEM_PCRE} ]; then
        cd /opt/mod && wget https://github.com/PCRE2Project/pcre2/archive/refs/tags/pcre2-${SYSTEM_PCRE}.tar.gz
        cd /opt/mod && tar xf pcre2-${SYSTEM_PCRE}.tar.gz; rm -Rf pcre2-${SYSTEM_PCRE}.tar.gz
        cd /opt/mod/pcre2-pcre2-${SYSTEM_PCRE} && ./autogen.sh 
    fi

    # LibInjection
    if [ ! -d /opt/mod/libinjection ]; then
        cd /opt/mod && git clone https://github.com/libinjection/libinjection.git
        cd /opt/mod/libinjection && ./autogen.sh && make -j`nproc` && make install
    fi
    # END OF SYSTEM REQUIRED LIBS
    # ============================================================================================================


    # START OF NGINX MODULES
    # ============================================================================================================
    # NGX_MOD_LUA
    if [ ! -d /opt/mod/lua-nginx-module-${NGX_MOD_LUA} ]; then
        cd /opt/mod/; wget https://github.com/openresty/lua-nginx-module/archive/refs/tags/v${NGX_MOD_LUA}.tar.gz
        cd /opt/mod/; tar xf v${NGX_MOD_LUA}.tar.gz; rm -Rf v${NGX_MOD_LUA}.tar.gz
    fi

    # NGX_MOD_DEVELKIT
    if [ ! -d /opt/mod/ngx_devel_kit-${NGX_MOD_DEVELKIT} ]; then
        cd /opt/mod/; wget https://github.com/vision5/ngx_devel_kit/archive/refs/tags/v${NGX_MOD_DEVELKIT}.tar.gz
        cd /opt/mod/; tar xf v${NGX_MOD_DEVELKIT}.tar.gz; rm -Rf v${NGX_MOD_DEVELKIT}.tar.gz
    fi

    # NGX_MOD_GEOIP2
    if [ ! -d /opt/mod/ngx_http_geoip2_module-${NGX_MOD_GEOIP2} ]; then
        cd /opt/mod/; wget https://github.com/leev/ngx_http_geoip2_module/archive/refs/tags/${NGX_MOD_GEOIP2}.tar.gz
        cd /opt/mod/; tar xf ${NGX_MOD_GEOIP2}.tar.gz; rm -Rf ${NGX_MOD_GEOIP2}.tar.gz
    fi

    # NGX_MOD_MODSECURITY
    if [ ! -d /opt/mod/ModSecurity-nginx-${NGX_MOD_MODSECURITY} ]; then
        cd /opt/mod/; wget https://github.com/SpiderLabs/ModSecurity-nginx/archive/refs/tags/v${NGX_MOD_MODSECURITY}.tar.gz
        cd /opt/mod/; tar xf v${NGX_MOD_MODSECURITY}.tar.gz; rm -Rf v${NGX_MOD_MODSECURITY}.tar.gz
    fi

    # NGX_MOD_HTTPFLV
    if [ ! -d /opt/mod/nginx-http-flv-module-${NGX_MOD_HTTPFLV} ]; then
        cd /opt/mod/; wget https://github.com/winshining/nginx-http-flv-module/archive/refs/tags/v${NGX_MOD_HTTPFLV}.tar.gz
        cd /opt/mod/; tar xf v${NGX_MOD_HTTPFLV}.tar.gz; rm -Rf v${NGX_MOD_HTTPFLV}.tar.gz
    fi

    # NGX_MOD_HEADERS_MORE
    if [ ! -d /opt/mod/headers-more-nginx-module-${NGX_MOD_HEADERS_MORE} ]; then
        cd /opt/mod/; wget https://github.com/openresty/headers-more-nginx-module/archive/refs/tags/v${NGX_MOD_HEADERS_MORE}.tar.gz
        cd /opt/mod/; tar xf v${NGX_MOD_HEADERS_MORE}.tar.gz; rm -Rf v${NGX_MOD_HEADERS_MORE}.tar.gz
    fi

    # NGX_MOD_SETMISC
    if [ ! -d /opt/mod/set-misc-nginx-module-${NGX_MOD_SETMISC} ]; then
        cd /opt/mod/; wget https://github.com/openresty/set-misc-nginx-module/archive/refs/tags/v${NGX_MOD_SETMISC}.tar.gz
        cd /opt/mod/; tar xf v${NGX_MOD_SETMISC}.tar.gz; rm -Rf v${NGX_MOD_SETMISC}.tar.gz
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
     
    # END OF NGINX MODULES
    # ============================================================================================================
}

test_nginx() {
    cd /opt/nginx-${NGINX} && LUAJIT_LIB="/usr/local/LuaJIT/lib" LUAJIT_INC="/usr/local/LuaJIT/include/luajit-2.1/" ./configure --with-compat \
                                          --user=nginx                                                            \
                                          --group=nginx                                                           \
                                          --sbin-path=/usr/sbin/nginx                                             \
                                          --conf-path=/nginx/nginx.conf                                           \
                                          --pid-path=/var/run/nginx.pid                                           \
                                          --lock-path=/var/run/nginx.lock                                         \
                                          --error-log-path=/var/log/nginx/error.log                               \
                                          --http-log-path=/var/log/nginx/access.log                               \
                                          --with-openssl=/opt/mod/openssl-OpenSSL_${SYSTEM_OPENSSL}               \
                                          --with-pcre                                                             \
                                          --with-pcre=/opt/mod/pcre2-pcre2-${SYSTEM_PCRE}                         \
                                          --with-zlib=/opt/mod/zlib                                               \
                                          --with-threads                                                          \
                                          --with-file-aio                                                         \
                                          --with-http_ssl_module                                                  \
                                          --with-http_v2_module                                                   \
                                          --with-http_realip_module                                               \
                                          --with-http_addition_module                                             \
                                          --with-http_xslt_module                                                 \
                                          --with-http_image_filter_module                                         \
                                          --with-http_geoip_module                                                \
                                          --with-http_sub_module                                                  \
                                          --with-http_dav_module                                                  \
                                          --with-http_flv_module                                                  \
                                          --with-http_mp4_module                                                  \
                                          --with-http_gunzip_module                                               \
                                          --with-http_gzip_static_module                                          \
                                          --with-http_auth_request_module                                         \
                                          --with-http_random_index_module                                         \
                                          --with-http_secure_link_module                                          \
                                          --with-http_slice_module                                                \
                                          --with-http_stub_status_module                                          \
                                          --with-mail                                                             \
                                          --with-mail_ssl_module                                                  \
                                          --with-stream                                                           \
                                          --with-stream_ssl_module                                                \
                                          --with-stream_realip_module                                             \
                                          --with-stream_geoip_module                                              \
                                          --add-module=/opt/mod/ngx_devel_kit-${NGX_MOD_DEVELKIT}                 \
                                          --add-module=/opt/mod/set-misc-nginx-module-${NGX_MOD_SETMISC}          \
                                          --add-module=/opt/mod/ngx_http_geoip2_module-${NGX_MOD_GEOIP2}          \
                                          --add-module=/opt/mod/headers-more-nginx-module-${NGX_MOD_HEADERS_MORE} \
                                          --add-module=/opt/mod/lua-nginx-module-${NGX_MOD_LUA}                   \
                                          --add-module=/opt/mod/ModSecurity-nginx-${NGX_MOD_MODSECURITY}          \
                                          --add-module=/opt/mod/naxsi/naxsi_src                                   \
                                          --add-module=/opt/mod/nginx-http-flv-module-${NGX_MOD_HTTPFLV}          \
                                          --add-module=/opt/mod/ngx_brotli                                        \
                                          --add-module=/opt/mod/testcookie                                        \
                                          --with-cc-opt="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC" \
                                          --with-ld-opt="-Wl,-rpath,/usr/local/LuaJIT/lib -Wl,-rpath,/usr/local/lib -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie"
                                          make clean
}
function build() {
    cd /opt/nginx-${NGINX} && LUAJIT_LIB="/usr/local/LuaJIT/lib" LUAJIT_INC="/usr/local/LuaJIT/include/luajit-2.1/" ./configure --with-compat \
                                          --user=nginx                                                            \
                                          --group=nginx                                                           \
                                          --sbin-path=/usr/sbin/nginx                                             \
                                          --conf-path=/nginx/nginx.conf                                           \
                                          --pid-path=/var/run/nginx.pid                                           \
                                          --lock-path=/var/run/nginx.lock                                         \
                                          --error-log-path=/var/log/nginx/error.log                               \
                                          --http-log-path=/var/log/nginx/access.log                               \
                                          --with-openssl=/opt/mod/openssl-OpenSSL_${SYSTEM_OPENSSL}               \
                                          --with-pcre                                                             \
                                          --with-pcre=/opt/mod/pcre2-pcre2-${SYSTEM_PCRE}                         \
                                          --with-zlib=/opt/mod/zlib                                               \
                                          --with-threads                                                          \
                                          --with-file-aio                                                         \
                                          --with-http_ssl_module                                                  \
                                          --with-http_v2_module                                                   \
                                          --with-http_realip_module                                               \
                                          --with-http_addition_module                                             \
                                          --with-http_xslt_module                                                 \
                                          --with-http_image_filter_module                                         \
                                          --with-http_geoip_module                                                \
                                          --with-http_sub_module                                                  \
                                          --with-http_dav_module                                                  \
                                          --with-http_flv_module                                                  \
                                          --with-http_mp4_module                                                  \
                                          --with-http_gunzip_module                                               \
                                          --with-http_gzip_static_module                                          \
                                          --with-http_auth_request_module                                         \
                                          --with-http_random_index_module                                         \
                                          --with-http_secure_link_module                                          \
                                          --with-http_slice_module                                                \
                                          --with-http_stub_status_module                                          \
                                          --with-mail                                                             \
                                          --with-mail_ssl_module                                                  \
                                          --with-stream                                                           \
                                          --with-stream_ssl_module                                                \
                                          --with-stream_realip_module                                             \
                                          --with-stream_geoip_module                                              \
                                          --add-module=/opt/mod/ngx_devel_kit-${NGX_MOD_DEVELKIT}                 \
                                          --add-module=/opt/mod/set-misc-nginx-module-${NGX_MOD_SETMISC}          \
                                          --add-module=/opt/mod/ngx_http_geoip2_module-${NGX_MOD_GEOIP2}          \
                                          --add-module=/opt/mod/headers-more-nginx-module-${NGX_MOD_HEADERS_MORE} \
                                          --add-module=/opt/mod/lua-nginx-module-${NGX_MOD_LUA}                   \
                                          --add-module=/opt/mod/ModSecurity-nginx-${NGX_MOD_MODSECURITY}          \
                                          --add-module=/opt/mod/naxsi/naxsi_src                                   \
                                          --add-module=/opt/mod/nginx-http-flv-module-${NGX_MOD_HTTPFLV}          \
                                          --add-module=/opt/mod/ngx_brotli                                        \
                                          --add-module=/opt/mod/testcookie                                        \
                                          --with-cc-opt="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC" \
                                          --with-ld-opt="-Wl,-rpath,/usr/local/LuaJIT/lib -Wl,-rpath,/usr/local/lib -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie"
                                          make -j`nproc` && make install && make clean
}
function post_conf() {
    useradd nginx; unset NGINX; rm -rf /nginx/*.default;
    mkdir -p /nginx/live
    mkdir -p /nginx/conf.d
    mkdir -p /nginx/config
}

# Handling command-line arguments
case "$1" in
    new)
        reqs
        clean_install
        ;;
    test)
        test_nginx
        ;;
    build)
        build
        ;;
    *)
        echo "Invalid option: $1"
        echo "Usage: $0 {new|test|build}"
        echo "  new: Installs requirements, redownloads all modules and nginx (existing /opt/mod && /opt/nginx* will get deleted)"
        echo "  test: Test nginx configuration for errors"
        echo "  build: Compile nginx and install it on server"
        exit 1
        ;;
esac

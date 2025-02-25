# Nginx L7 DDoS Protection! :boom: :zap:

![Simple](https://c.tenor.com/uYqsM9uIyuYAAAAC/simple-easy.gif)

- [x] **Support Ubuntu 22.04**
- [x] **Latest Nginx 1.26.0**
- [x] **HTTP/3**
- [x] **Admin Panel** : Optional *(Not installed by default)*
     - [X] **Home Page** *(Nginx stats/graph via nginx stub stats)*
     - [X] **Vhosts Page** *(Create, Delete, Edit)*
     - [ ] **IP Management** *(add, edit, delete)* *selectable on vhost creation*
     - [ ] **Ports Management** *(add, edit, delete)* *selectable on vhost creation*
     - [ ] **Nginx Settings Page** *(Only change existing nginx.conf values)*
     - [ ] **Log Reporting Page** (Not set yet, might be all in one page or seperated pages for access logs, modsec logs)
     - [ ] **Php Selector** (a.k.a creation of dedicated fpm pool) *selectable on vhost creation*
     - [ ] **One click App installer** *(WordPress)*
- [x] ModSecurity Support *(Ngx Mod)*
- [x] Naxsi Support *(Ngx Mod)*
- [x] Lua Support.
     - [X] **AutoSSL** *(Lua Mod)*
     - [ ] **Rate Limit** *(Lua Mod)*
     - [ ] **Captcha**  *(Lua Mod)*
- [x] Cookie Based Challenge *(Ngx Mod)*
- [x] [Versions List](https://github.com/theraw/The-World-Is-Yours/blob/master/version)

# Installation methods.

- 1 : **Repository (Easy)**
     ```bash
     # Add repository and update system.
     echo '' > /etc/apt/sources.list.d/the-world-is-yours.list
     apt-get update; apt-get upgrade -y
     
     # Install nginx.
     apt-get install raweb -y

     # Install admin panel.
     apt-get install raweb-admin -y
     ```
- 2 : **Manual .deb (Med)**
     ```bash
     Download them from : https://github.com/theraw/The-World-Is-Yours/releases
     ```
- 3 : **Compile from source (Hard)**
     ```bash
     apt-get -y install git && cd /root/ && git clone https://github.com/theraw/The-World-Is-Yours.git && cd The-World-Is-Yours/

     bash build/run.sh new
     bash build/run.sh build
     bash build/run.sh postfix
     ```
     - 3.1 : **Compiling from source with changed versions**
          ```bash
          # assuming you completed step 3.
          # update "version" file then run again
          bash build/run.sh new
          bash build/run.sh build
          ```
          


## CLI Info
```bash
bash build/run.sh new     => Download all modules + nginx that are missing from /opt/. (If you make version changes to 'version' file then simply rerun this to download again)
bash build/run.sh build   => This is going to simply compile nginx nothing else. (You can run this as many times as you need, its not going to replace configs)
bash build/run.sh postfix => This will redownload /nginx/nginx.conf everytime you run it. (Suggested to run only once when you install nginx via my repo for first time)
```


## Nginx Structure.

```bash
=> Nginx Folder     = /nginx/
=> --conf-path      = /nginx/nginx.conf
=> --pid-path       = /var/run/nginx.pid 
=> --user           = nginx 
=> --group          = nginx
=> --sbin-path      = /usr/sbin/nginx
=> --error-log-path = /var/log/nginx/error.log

LUA RESTY CORE SCRIPTS = /usr/nginx_lua

# Admin Panel Info
=> Folder           = /nginx/admin/public_html 
```

## How to install lua scripts 

- Method 1
  ```bash
  . /root/The-World-Is-Yours/version
  cd /opt/mod/; git clone https://github.com/openresty/lua-resty-lrucache.git
  cd /opt/mod/lua-resty-lrucache; make install PREFIX=${LUA_SCRIPTS}
  nginx -s reload
  ```
- Method 2
  ```bash
  # At first when you use this method you may get errors for missing lua scripts, you can install them with "luarocks".
  apt-get install luarocks
  luarocks install lua-resty-lrucache
  ```

# Support options.

- No free support for how to do things, please don't spam with questions in discord.
- Free support for installation related errors only, is included.

- Business inquiries, regarding anti-ddos protection or other security/optimization concerns you can contact me on : raw@dopehosting.net


## Contributors

Feel free to submit a pull request.
Special thanks to the following contributors:

<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
	<tr>
		<td align="center">
			<a href="https://github.com/theraw">
				<img src="https://avatars.githubusercontent.com/u/32969774?v=4" width="80" alt=""/>
				<br /><sub><b>ƬHE ЯAW ☣</b></sub>
			</a>
		</td>
		<td align="center">
			<a href="https://github.com/lucthienphong1120">
				<img src="https://avatars.githubusercontent.com/u/90561566?v=4" width="80" alt=""/>
				<br /><sub><b>Lục Thiên Phong</b></sub>
			</a>
		</td>
	</tr>
</table>

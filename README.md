# Nginx L7 DDoS Protection! :boom: :zap:

![Simple](https://c.tenor.com/uYqsM9uIyuYAAAAC/simple-easy.gif)

- [x] Support Ubuntu 22.04
- [x] Latest Nginx 1.26.0
- [x] ModSecurity Support.
- [x] Naxsi Support.
- [x] Lua Support.
- [x] Cookie Based Challenge.
- [x] [Versions List](https://github.com/theraw/The-World-Is-Yours/blob/master/version)

## Compile from source
```bash
apt-get -y install git && cd /root/ && git clone https://github.com/theraw/The-World-Is-Yours.git && cd The-World-Is-Yours/

bash build/run.sh new
bash build/run.sh build
bash build/run.sh postfix
```

If you want to try with a custom nginx version then, open `version` file and change versions then run
```bash
bash build/run.sh new
bash build/run.sh build
```
## CLI Info
```
bash build/run.sh new     => Download all modules + nginx that are missing from /opt/. (If you make version changes to 'version' file then simply rerun this to download again)
bash build/run.sh build   => This is going to simply compile nginx nothing else. (You can run this as many times as you need, its not going to replace configs)
bash build/run.sh postfix => This will redownload /nginx/nginx.conf everytime you run it. (Suggested to run only once when you install nginx via my repo for first time)
```


## Nginx info.

```
=> Nginx Folder     = /nginx/
=> --conf-path      = /nginx/nginx.conf
=> --pid-path       = /var/run/nginx.pid 
=> --user           = nginx 
=> --group          = nginx
=> --sbin-path      = /usr/sbin/nginx
=> --error-log-path = /var/log/nginx/error.log

LUA RESTY CORE SCRIPTS = /usr/nginx_lua
```

## How to install lua scripts 
```
. /root/The-World-Is-Yours/version
cd /opt/mod/; git clone https://github.com/openresty/lua-resty-lrucache.git
cd /opt/mod/lua-resty-lrucache; make install PREFIX=${LUA_SCRIPTS}
nginx -s reload
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

# Nginx L7 DDoS Protection! :boom: :zap:

![Simple](https://c.tenor.com/uYqsM9uIyuYAAAAC/simple-easy.gif)

- [x] Debian 13 (trixie) and Ubuntu 26.04 LTS (raccoon) supported
- [x] nginx 1.30.0
- [x] HTTP/3 (QUIC) via AWS-LC
- [x] ModSecurity v3 (libmodsecurity)
- [x] Naxsi
- [x] Lua (LuaJIT 2.1)
- [x] Cookie-based challenge
- [x] [Versions List](https://git.julio.al/theraw/The-World-Is-Yours/src/branch/master/version)

## Note

I am no longer maintaining the github repo actively, because github has started charging for self hosted runners which this project requires, so the project is moved to https://git.julio.al/theraw/The-World-Is-Yours

## Easy install

### Debian 13 (trixie)
```bash
sudo install -d /etc/apt/keyrings
sudo curl -fsSL https://apt.julio.al/repository/public/keys/raweb.asc -o /etc/apt/keyrings/raweb.asc
echo "deb [signed-by=/etc/apt/keyrings/raweb.asc] https://apt.julio.al/repository/raweb-trixie trixie main" | sudo tee /etc/apt/sources.list.d/raweb.list
sudo apt update && sudo apt install twiy
```

### Ubuntu 26.04 LTS (raccoon)
```bash
sudo install -d /etc/apt/keyrings
sudo curl -fsSL https://apt.julio.al/repository/public/keys/raweb.asc -o /etc/apt/keyrings/raweb.asc
echo "deb [signed-by=/etc/apt/keyrings/raweb.asc] https://apt.julio.al/repository/raweb-raccoon raccoon main" | sudo tee /etc/apt/sources.list.d/raweb.list
sudo apt update && sudo apt install twiy
```

## Compile from source

Pick the script that matches your OS — they're separate so apt package
divergences (e.g. the t64 ABI transition on Ubuntu 24.04+) stay isolated.

```bash
apt-get -y install git && cd /root/ && git clone https://git.julio.al/theraw/The-World-Is-Yours.git && cd The-World-Is-Yours/

# Debian 13
bash build/trixie.sh new
bash build/trixie.sh build
bash build/trixie.sh postfix

# Ubuntu 26.04 LTS
bash build/raccoon.sh new
bash build/raccoon.sh build
bash build/raccoon.sh postfix
```

To try a different upstream version, edit `version` and re-run `new` then `build`.

## CLI Info
```
bash build/<distro>.sh new     => Download all modules + nginx that are missing from /opt/.
                                  (Re-run after changing the `version` file to fetch new versions.)
bash build/<distro>.sh build   => Compile nginx. Re-runnable; will not touch your configs.
bash build/<distro>.sh postfix => Drop the default /nginx/nginx.conf, vhost, and systemd unit
                                  into place. Run once on first install; re-running overwrites
                                  /nginx/nginx.conf.
```
where `<distro>` is `trixie` or `raccoon`.


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

## Performance

### vs. vanilla nginx (same version, default config)

| Area | Twiy | Vanilla nginx | Why |
|---|---|---|---|
| TLS handshake throughput | **+5–15%** | baseline | AWS-LC's tuned AES/ChaCha asm vs OpenSSL |
| WAF, Lua, HTTP/3 | included | not included | needs custom build |

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

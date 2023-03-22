# Nginx L7 DDoS Protection! :boom: :zap: [![Docker Image CI](https://github.com/theraw/The-World-Is-Yours/workflows/BobTheBuilder/badge.svg?branch=master)](https://github.com/theraw/The-World-Is-Yours/actions/workflows/docker-image.yml)
Now easier then before, you will have to compile only Nginx, Rest of modules come pre-compiled.
![Simple](https://c.tenor.com/uYqsM9uIyuYAAAAC/simple-easy.gif)

- [x] Support Ubuntu 20.04.
- [x] Support Ubuntu 22.04.1

-- Security Dynamic Modules.
 - [x] ModSecurity Support.
 - [x] Naxsi Support.
 - [x] Lua Support.
 - [x] Cookie Based Challenge.
 - [x] [MOD LIST X Ubuntu 20.04](https://github.com/theraw/The-World-Is-Yours/tree/master/static/Focal/mod)
 - [x] [MOD LIST X Ubuntu 22.04](https://github.com/theraw/The-World-Is-Yours/tree/master/static/Jammy/mod)
 - [x] [Versions](https://github.com/theraw/The-World-Is-Yours/blob/master/version)
 
How do these 3 modules work together? L7 will block all or most of bots, ModSecurity and Naxsi take priority over cookie challenge!
So if its a offensive request that Modsecurity or Naxsi detect it as such then these 2 will deal with that request otherwise cookie challenge will appear.

## INSTALLATION

1. **`apt-get update; apt-get -y install build-essential libssl-dev curl nano wget zip unzip sudo git psmisc tar`**

2. **`curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/install > install; bash install`**

## OR RUN IN DOCKER

1. **`git clone https://github.com/theraw/The-World-Is-Yours.git; cd The-World-Is-Yours`**

2. **`docker build -t mybuild .`**

3. **`docker run -d mybuild`**


## Basic info.

```
=> Nginx Folder     = /nginx/
=> --conf-path      = /nginx/nginx.conf
=> --pid-path       = /var/run/nginx.pid 
=> --user           = nginx 
=> --group          = nginx
=> --sbin-path      = /usr/sbin/nginx
=> --error-log-path = /var/log/nginx/error.log

LUA RESTY CORE SCRIPTS = /usr/twiylua/

// YOUR NGINX IS LOCATED AT /nginx NOT /etc/nginx
```


## KEEP IN MIND!
1. You're trading perfomance for security.
2. If your server provider does not have anti-ddos your IPTABLES will fail to keep the bans, and your server may be offline in cases of big attacks.
3. This is not a script that with one command your ddos problem is fixed, there's no such thing for L7 attacks as they change and new methods come out very often and no one has any ideas where your server is lacking security so this script is a basic thing more advanced protection require knowledge, monitoring logs, and applying filters in order to automatically ban attackers, this project gives you the tools how you do the job is up to you!

## Premium Available.

As anything else on internet a **Pro** Version of this is available and not released to public, is actually possible in 2 ways.

1. Monthly billing, is like a managed plan you will be offered reverse-proxy, you can customize filters even yourself.

2. One time payment, you can purchase a one time payment script that can detect proxies, rate limit, cacheable, autoban, easily to change filter or action. *(one time payment option has no support you'll be given the script and you're on your own!)*

The second offer (2), is not a php script 😂 .
you can write me on discord or `raw@dopehosting.net`

## Contributors

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

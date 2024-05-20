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

## Compile from source
```
git clone
cd The-World-Is-Yours/
bash run.sh new
bash run.sh build
```



## Basic info.

```
=> Nginx Folder     = /nginx/
=> --conf-path      = /nginx/nginx.conf
=> --pid-path       = /var/run/nginx.pid 
=> --user           = nginx 
=> --group          = nginx
=> --sbin-path      = /usr/sbin/nginx
=> --error-log-path = /var/log/nginx/error.log

LUA RESTY CORE SCRIPTS = /usr/nginx_lua/

// YOUR NGINX IS LOCATED AT /nginx NOT /etc/nginx
```


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

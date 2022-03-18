# Nginx L7 DDoS Protection! :boom: :zap:
Now easier then before, you will have to compile only Nginx, Rest of modules come pre-compiled.


- [x] Support Ubuntu 20.04.

-- Compiled As Dynamic Modules.
 - [x] ModSecurity Support.
 - [x] Naxsi Support.
 - [x] Cookie based Authentication.

# INSTALLATION

1. **`apt-get install build-essential libssl-dev curl nano wget zip unzip sudo git psmisc -y`**

2. **`curl -s https://raw.githubusercontent.com/theraw/The-World-Is-Yours/master/install > install; bash install`**

# FOLDER PATH.

```
=> /nginx/                                = Nginx Path, (private)
=> /nginx/live/                           = Vhosts Configs (private)
=> /nginx/modsecurity/                    = ModSecurity Rules Dir (private)
=> /hostdata/                             = Place to store your domain folders. (private)
=> /hostdata/yourdomain.com/              = Ex of domain dir (private folder),
=> /hostdata/yourdomain.com/public_html/  = Ex of your domain webroot (public files only),
=> /hostdata/yourdomain.com/logs/         = Place where to store your Domains logs (access.log) (private folder),
=> /hostdata/yourdomain.com/ssl/          = Place where to store domain ssl/key (private folder),
=> /hostdata/yourdomain.com/cache/        = Place where to store site cache (private folder).

// Private Folder - Means this cannot be accessed by public.
// Public Folder  - Means files into this folder can be accessed by public.
```


# KEEP IN MIND!
1. You're trading perfomance for security.
2. If your server provider does not have anti-ddos your IPTABLES will fail to keep the bans, and your server may be offline in cases of big attacks.

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
 </tr>
</table>

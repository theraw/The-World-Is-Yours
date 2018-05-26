# Nginx L7 DDoS Protection! :boom: :zap:
*(Please Read Whole Page, All Things Are Important Then If You Want You Can Use IT.)*

During the installation maybe it can fail, please create one issue if it happen. The reason can be maybe if your system is 32bit only, because i have test this script only with 64bit. 

Another reason can be missing packages from your repository. if so please for Ubuntu 14.04 change your repo to [THIS](https://raw.githubusercontent.com/theraw/raws/master/usr/local/raws/ubuntu/eu-repo) .

# To-Do

- [x] Support Ubuntu Trusty.
- [x] Support Ubuntu Xenial.
- [ ] Support Debian.
- [ ] Support Centos.
- [x] Support Arch Linux.
- [x] ModSecurity Support.
- [x] Naxsi Support.
- [x] L7 Protection.
- [x] AutoBan System.
- [x] Integrate Fail2Ban > IpTables.
- [ ] GUI ?
- [ ] Monitor requests in live time from browser.
- [ ] .....

# Installation

As of now available for use is just Ubuntu version. (Ubuntu 14.04) to try it you need to have a fresh installation of 
Ubuntu 14.04 in you VM/VPS/DEDICATED so 

1. **`git clone https://github.com/theraw/The-World-Is-Yours.git`**

2. **`cd The-World-Is-Yours/; chmod +x *`**

3. **`./install`**


# Informations.
```
=> /nginx/                                = Nginx Path,
=> /nginx/live/                           = Vhosts Config Files Dir,
=> /nginx/logs/                           = Core Logs Files,
=> /nginx/modsecurity/                    = ModSecurity Rules Dir,
=> /hostdata/                             = Place to store your domain folders.
=> /hostdata/yourdomain.com/              = Ex of domain dir (private folder),
=> /hostdata/yourdomain.com/public_html/  = Ex of your domain webroot (public files only),
=> /hostdata/yourdomain.com/logs/         = Place where to store your Domains logs (access.log) (private folder),
=> /hostdata/yourdomain.com/ssl/          = Place where to store domain ssl/key (private folder),
=> /hostdata/yourdomain.com/cache/        = Place where to store site cache (private folder).

// Private Folder - Means this cannot be accessed by public.
// Public Folder  - Means files into this folder can be accessed by public.
```


# Check.

1 . [L7 (Cookie Based Protection)](https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L15-L42) AND [Replace "proxy2.dope.. links with yours click here to find aes](https://github.com/theraw/The-World-Is-Yours/tree/master/static/vhost) which should be stored on a external link or in a place where L7 is disabled because it will not work if you put it in main site dir!.

2 . [Auto Ban System](https://github.com/theraw/The-World-Is-Yours/blob/master/iptables/jail.local#L105-L111) based on [Connection for ip](https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L72-L73)

3 . [Auto Ban 444 Reqs](https://github.com/theraw/The-World-Is-Yours/blob/master/iptables/jail.local#L113-L118) A day i've been under attack of multiple proxies, and even after they got banned they still was keep trying the same thing so when you ban someone when that ip tries to access your website that request will not go on `error.log` but in `access.log` so i created this rule to ban with iptables every request who have stauts `444` so nginx will not have to handle those.

4 . [Kernel Settings](https://github.com/theraw/The-World-Is-Yours/blob/master/static/sysctl.conf#L1-L34)

5 . [Naxsi Rules Included](https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L118)

6 . [Example of Naxsi](https://github.com/theraw/The-World-Is-Yours/blob/master/static/vhost/default#L22-L29)

7 . [Check Iptables rules](https://github.com/theraw/The-World-Is-Yours/blob/master/iptables/rules) It will not be automatically enabled, because this changes based on providers in ovh it work in azure it doesn't work. so you need to manually activate iptables!

8 . ModSecurity is not loaded. However you need to set it up by yourself. you have a folder `/nginx/modsecurity/`
which ModSecurity rules are stored, open `/nginx/modsecurity/modsecurity.conf` add those

```bash
Include crs-setup.conf
Include rules/*.conf
```
ModSecurity is by default enabled as "detect only" you can turn it on always by doing this

```bash
SecRuleEngine On
```

Using modSecurity for your site
```bash
server { 
     ..... 
        modsecurity on;
        modsecurity_rules_file /nginx/modsecurity/modsecurity.conf; 
        location / { 
     ..... 
        } 
}
```
**Careful** Using modsec rules like
```
   location / { 
       modsecurity_rules_file /nginx/modsecurity/modsecurity.conf; 
   } 
```
it means that's enabled just for your main place `/` not for other dirs in your site ex `/admin/` (:


Test it!
`curl 'http://localhost/?q="><script>wanna hack</script>'`
```html
<html>
<head><title>403 Forbidden</title></head>
<body bgcolor="white">
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

# Keep In Mind.
The **L7 Protection** is the same way which **cloudflare** have that banner "Under Attack" A.K.A Cookie based authorization. Most of bots from where attacks will come doesn't support cookies so it will fail to access your site. (Test it by yourself to "curl http://yoursite.com" before you activate L7 and after you start L7 so you will understand better.)

The L7 protection is a good thing for your protection. But a very bad thing for your website seo!, As facebook/google/bing and all search engines will not be able to access your website anymore. There is a way to allow them but if you have 1 year free time to find all their ips go and try it. I've been thinking for a "reverse dns" whitelist but haven't done it so as of now it is like this.

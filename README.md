# Nginx L7 DDoS Protection! :boom: :zap:
*(Please Read Whole Page, All Things Are Important Then If You Want You Can Use IT.)*

# To-Do

- [x] Nginx Version, Always Latest.
- [x] Support Ubuntu Trusty. (14.04)
- [x] Support Ubuntu Xenial. (16.04)
- [x] Support Ubuntu Cosmic. (18.10)
- [x] Support Debian.
- [x] Support Centos.
- [x] Support Arch Linux.
- [x] ModSecurity Support.
- [x] Naxsi Support.
- [x] L7 Protection.
- [x] AutoBan System.
- [x] Integrate Fail2Ban > IpTables.
- [-] GUI ?
- [-] Monitor requests in live time from browser.
- [-] L7 Protection (TestCookie Module) Add Recaptcha!
- [-/x] .....

# Installation

1. **`apt-get install build-essential libssl-dev curl nano wget zip unzip sudo git psmisc -y`**

2. **`git clone https://github.com/theraw/The-World-Is-Yours.git`**

3. **`cd The-World-Is-Yours/; chmod +x *`**

4. **`./install`**


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

1 . [L7 (Cookie Based Protection)](https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L15-L42)

2 . [Auto Ban System](https://github.com/theraw/The-World-Is-Yours/blob/master/iptables/jail.local#L105-L111) based on [Connection for ip](https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L72-L73)

3 . [Auto Ban 444 Reqs](https://github.com/theraw/The-World-Is-Yours/blob/master/iptables/jail.local#L113-L118) A day i've been under attack of multiple proxies, and even after they got banned they still was keep trying the same thing so when you ban someone when that ip tries to access your website that request will not go on `error.log` but in `access.log` so i created this rule to ban with iptables every request who have stauts `444` so nginx will not have to handle those.

4 . [Kernel Hardening](https://github.com/theraw/The-World-Is-Yours/blob/master/static/sysctl.conf), Use this if you have a Gbps uplink 4+GB RAM, A good CPU and SSD.

5 . [Naxsi Rules Included](https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L118)

6 . [Iptables rules](https://github.com/theraw/The-World-Is-Yours/blob/master/iptables/rules) You have to manually enable.

7 . ModSecurity is not loaded. You have to manually enable. In your server there is a folder `/nginx/modsecurity/`
where ModSecurity rules are stored, open `/nginx/modsecurity/modsecurity.conf` add those

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

# Why manual activation?
Actually i'm just creating a open source build script for nginx with some features, so this is not just a full build in pack with everything enabled, you should actually have some knowledge about how those things work so i don't think it should be hard to do by yourself?!

# Issues.
Please remember that i have just created a bash script that compiles nginx with some modules from source i'm not the developer of nginx nor used modules so you may not get much help but i'll help as much as i can.

# Keep In Mind.
The **L7 Protection** is the same way which **cloudflare** have that banner "Under Attack" A.K.A Cookie based authorization. Most of bots from where attacks will come doesn't support cookies so it will fail to access your site. (Test it by yourself to "curl http://yoursite.com" before you activate L7 and after you start L7 so you will understand better.)

The L7 protection is a good thing for your protection. But a very bad thing for your website seo!, As facebook/google/bing and all search engines will not be able to access your website anymore. There is a way to allow them but if you have 1 year free time to find all their ips go and try it. I've been thinking for a "reverse dns" whitelist but haven't done it so as of now it is like this.

# Contributors

Feel free to pull request or do a suggestion..

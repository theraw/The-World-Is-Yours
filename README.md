# Nginx L7 DDoS Protection! :boom: :zap:

As of now available for use is just Ubuntu version. (Ubuntu 14.04) to try it you need to have a fresh installation of 
Ubuntu 14.04 in you VM/VPS/DEDICATED so 

1. **`git clone https://github.com/theraw/The-World-Is-Yours.git`**

2. **`cd The-World-Is-Yours/; chmod +x *`**

3. **`./install`**

4. **`wget https://raw.githubusercontent.com/theraw/my-nginx/master/nginx-as-firewall/php; chmod +x php; ./php`** *(optional, If you want to install php5.6-fpm, runs on 127.0.0.1:9000)*


# Informations.

=> **`/nginx/`** - Nginx Path,

=> **`/ngnx/live/`** - Vhosts Config Files Dir,

=> **`/nginx/modsecurity/`** - ModSecurity Rules Dir.


# Check.

1. L7 (Cookie Based Protection) => https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L19-L301

2. Kernel Settings              => https://github.com/theraw/The-World-Is-Yours/blob/master/static/sysctl.conf#L1-L34

3. Naxsi Rules Included         => https://github.com/theraw/The-World-Is-Yours/blob/master/static/nginx.conf#L392
example of Naxsi => https://github.com/theraw/The-World-Is-Yours/blob/master/static/vhost/default#L8-L15

4. ModSecurity is not loaded. However you need to set it up by yourself. you have a folder `/nginx/modsecurity/`
where its stored open `/nginx/modsecurity/modsecurity.conf` add those

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

# To-Do

[x] Create install script for Ubuntu.

[-] Create install script for Debian.

[-] Create install script for Centos.

[-] Integrate Fail2Ban > IpTables.

[-] ....

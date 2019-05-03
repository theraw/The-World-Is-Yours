# Nginx L7 DDoS Protection! :boom: :zap:
*(Please Read Whole Page, All Things Are Important Then If You Want You Can Use IT.)*

# To-Do

- [x] Nginx V. each 10th release, current 1.60.0, next repo release 1.70.0!
- [x] Support Ubuntu Bionic. (18.04)
- [x] ModSecurity Support.
- [x] Naxsi Support.
- [x] L7 Protection.
- [x] AutoBan System.
- [x] Integrate Fail2Ban > IpTables.
- [-] L7 Protection (TestCookie Module) Add Recaptcha!
- [-/x] [Suggestions](https://github.com/theraw/The-World-Is-Yours/issues)

# Installation
For each new system ubuntu, centos or whatever your distro may be you need a update/upgrade then do one reboot! So outdates packages will be up to date your kernel will be up to date and not needed files will get removed.

X. **`Ubuntu`**

1. **`apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y; shutdown -r now`**

2. **`apt-get install build-essential libssl-dev curl nano wget zip unzip sudo git psmisc -y`**

3. **[Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)**

4. **[Install Docker-Composer](https://github.com/docker/compose/releases) use latest version > execute provided cmds**

5. **`curl -s https:// > nginx.yml`**

6. **`docker-compose -f nginx.yml up -d`**




# Keep In Mind.
The **L7 Protection** is the same way which **cloudflare** have that banner "Under Attack" A.K.A Cookie based authorization. Most of bots from where attacks will come doesn't support cookies so it will fail to access your site. (Test it by yourself to "curl http://yoursite.com" before you activate L7 and after you start L7 so you will understand better.)

The L7 protection is a good thing for your protection. But a very bad thing for your website seo!, As facebook/google/bing and all search engines will not be able to access your website anymore. There is a way to allow them but if you have 1 year free time to find all their ips go and try it. I've been thinking for a "reverse dns" whitelist but haven't done it so as of now it is like this.

# Contributors

Feel free to pull request or do a suggestion..

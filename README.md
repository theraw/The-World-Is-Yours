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

# Q/A
-- Why are only latest distros supported and not some distro like Ubuntu 14.04?!

-- *Actually i'm a big fan of ubuntu 14.04 and some more old distros however, we should move with technology and be up to date, example for ubuntu 14.04 there are no security releases anymore furthermore one day it will be forgotten like ubuntu 12 or something else and so we should move with time*

-- What knowledge should i have to be able to run nginx L7 properly?!

-- *You should have at last basic knowledge about Nginx + Iptables and some docker, most of rules here will be premade that's why i'm creating a docker container so everything will come build-in and you'll not have to compile everything to avoid problems on set-up.*

-- How much can this set-up protect my website?

-- *This script is mostly meant for Layer 7 Attacks, However example if someone break some rule the ip from where this offence came will be banned by iptables for a perioid of time, now here is where your server provider plays a big role, when you ban a ip with iptables your provider should be able to handle that ban, there are many providers who claim that they can handle this but based on amount of attack not all can handle it so i've been using ovh all this time and i never had a problem about this.*

-- How much resources do i need for this?

-- *Actually that's based on kind of attack however i have run this setup even on a 1 Core 2.4Ghz, 4GB RAM, 40GB SSD, 100Mbps and everything has went well because i have the knowledge to optimize most of things and take care for everything, but i cannot deny that there were cases in big attacks where my webserver has went offline because of high cpu usage, so at that case i've shut down nginx i've filter and ban IPs from where attack came and i've been able to start nginx back all this happend in case of minutes... However as i said resources are more based on kind of attack because nginx uses multi-thread if you are using this setup for some company website or something really important i highly suggest you take someone who has really knowledge about those things so he/she can give you the best suggestion for how much resources you need and how to properly protect your website against L7 attacks*

-- Can i hire you?

-- *Yes, I can set this up however you want single server or load balancing + multi-backend, cache or no cache + varnish cache, company or a simple blog, I'm not that kind of person that just comes and says you "activate cloudflare" cloudflare claims to have protection against attack and maybe they do but i still see them only as a good DNS provider nothing else!  And if i fail on it you'll not pay anything! raw@dope.al*

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

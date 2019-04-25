# Nginx L7 DDoS Protection! :boom: :zap:
*(Please Read Whole Page, All Things Are Important Then If You Want You Can Use IT.)*

# To-Do

- [x] Nginx Version, Always Latest.
- [x] Support Ubuntu Trusty. (14.04)
- [x] Support Ubuntu Xenial. (16.04)
- [x] Support Ubuntu Cosmic. (18.10)
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
- [ ] L7 Protection (TestCookie Module) Add Recaptcha!
- [ ] .....

# Installation

1. **`Install Docker in your linux server or windows server, the docker must support linux containers.`**

2. **`Install Docker composer https://github.com/Yelp/docker-compose/blob/master/docs/install.md`**

3. **`curl -s > nginx-reverse.yml`**

4. **`docker-composer -f nginx-reverse.yml up -d`**

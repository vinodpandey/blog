## Installation
```sh
# nginx installation
vim /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/$basearch/
gpgcheck=0
enabled=1

yum -y install nginx
``
## Config
```sh
/etc/nginx/nginx.conf
/etc/nginx/conf.d/default.conf
```

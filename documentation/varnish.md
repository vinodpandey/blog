#### Installation
```sh
yum install epel-release
rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-4.1.el6.rpm

yum install varnish

varnishd -V
varnishd (varnish-4.1.2 revision 0d7404e)
Copyright (c) 2006 Verdens Gang AS
Copyright (c) 2006-2015 Varnish Software AS
```

#### Clear complete cache
```sh
varnishadm "ban req.url ~ ."
```
#### logging
```sh
varnishlog
# for testing a particular request
varnishlog | grep "request url path"
```

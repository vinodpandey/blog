#### Installation
```sh
sudo yum install epel-release
sudo rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-4.1.el6.rpm

sudo yum install varnish

varnishd -V
varnishd (varnish-4.1.2 revision 0d7404e)
Copyright (c) 2006 Verdens Gang AS
Copyright (c) 2006-2015 Varnish Software AS
```

#### Config Files
```sh
/etc/sysconfig/varnish
/etc/varnish/default.vcl
```

#### Starting/Stopping server
```sh
service varnish start/stop/restart
```

#### Clear complete cache
```sh
varnishadm "ban req.url ~ ."
```

#### Logging
```sh
varnishlog
# for testing a particular request
varnishlog | grep "request url path"
```

#### Links
* https://speakerdeck.com/thijsferyn/common-scenarios-in-vcl-varnish-summit-cph-2016
* https://www.datadoghq.com/blog/top-varnish-performance-metrics/
* http://www.slideshare.net/ivanchepurnyi/advanced-varnishusage?next_slideshow=1

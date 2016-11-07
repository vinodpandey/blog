
## Installation
```sh
sudo yum -y install httpd
```

## Start/stop
```sh
sudo service httpd start/stop/status/reload

# Run apache on system boot
sudo /sbin/chkconfig --levels 235 httpd on
```

## httpd in worker mode
```sh
vim /etc/sysconfig/httpd
# uncomment below line
HTTPD=/usr/sbin/httpd.worker
#restart http server
sudo service httpd restart
```

```sh
# Verifying that httpd is running in worker mode
# update httpd.conf file with below setting
sudo vim /etc/httpd/conf/httpd.conf

<Location /server-info>
    SetHandler server-info
    Order deny,allow
    Deny from all
    Allow from 127.0.0.1
</Location>

sudo service httpd restart

yum -y install lynx
lynx http://127.0.0.1/server-info
Server Setting > MPM Name - worker
```

## Name based virtual hosts
```sh
sudo vim /etc/httpd/conf/httpd.conf
# uncomment - 
NameVirtualHost *:80
```

```sh
sudo vim /etc/httpd/conf.d/example.com.vhost.conf
<VirtualHost *:80>
     ServerName example.com
     ServerAlias example.com
     DocumentRoot  /var/www/example.com
</VirtualHost>
```

## Processing Logs
```sh
# access per day 
awk '{print $4}' example.com | cut -d: -f1 | uniq -c

# access per hour
grep "23/Jan" example.com | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c

# access per minute
grep "23/Jan/2013:06" example.com | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":"$3}' | sort -nk1 -nk2 | uniq -c | awk '{ if ($1 > 10) print $0}'

# url accessed per day
grep "/downloads/getfile" access_log | cut -d'[' -f2 | cut -d: -f1 | uniq -c
```



## Config Files
```sh
/etc/httpd/conf/httpd.conf
```

## Log Files
```sh
# Error log
/etc/httpd/logs/error_log

# Access log 
/etc/httpd/logs/access_log
```

## Making a folder writable for apache
```sh
# find out the file owner name
ps -ef | grep httpd | grep -v grep

chgrp apache /path/to/mydir
chmod g+w /path/to/mydir
```

## Optimization
* http://www.tecmint.com/apache-performance-tuning/
* https://rudd-o.com/linux-and-free-software/tuning-an-apache-server-in-5-minutes

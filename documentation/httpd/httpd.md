
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


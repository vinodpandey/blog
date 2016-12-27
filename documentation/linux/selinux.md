
## semanage for managing permissions with selinux
```
yum -y install policycoreutils-python setroubleshoot-server
```

## Troubleshooting selinux errors
```
sealert -a /var/log/audit/audit.log > audit.txt
```

## Applying permissions
```
semanage fcontext -a -t httpd_sys_rw_content_t "/srv/test/plugins(/.*)?"
restorecon -Rv /srv/test
```

## Allowing httpd to bind to port 80
```
sudo setsebool -P  httpd_can_network_connect 1
```

## Allowing httpd to connect to remote database
```
sudo setsebool -P  httpd_can_network_connect_db 1
```

Ref:
* http://www.serverlab.ca/tutorials/linux/web-servers-linux/configuring-selinux-policies-for-apache-web-servers/
* https://www.disk91.com/2015/technology/systems/move-your-httpd-apache-files-on-centos-7/
* https://francispereira.com/deploying-wordpress-with-selinux-enabled.html

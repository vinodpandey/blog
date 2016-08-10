mysql debugging
http://www.pontikis.net/blog/how-and-when-to-enable-mysql-logs  


Login to mysql client:
```sh
mysql -u root -p 
```

To enabling logs at runtime:
```sql
SET GLOBAL general_log = 'ON';
SET GLOBAL slow_query_log = 'ON';
```

To disable logs at runtime:
```sql
SET GLOBAL general_log = 'OFF';
SET GLOBAL slow_query_log = 'OFF';
```

Error log at data dir (linux)
```sh
usually /var/lib/mysql in a file named {host_name}.log
```

Error log in MacOSX 
```sh
ps auxww|grep [m]ysqld
_mysql             89   0.0  0.2  3208428  40508   ??  Ss    1Mar16   2:39.50 /usr/local/mysql/bin/mysqld --user=_mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --plugin-dir=/usr/local/mysql/lib/plugin --log-error=/usr/local/mysql/data/mysqld.local.err --pid-file=/usr/local/mysql/data/mysqld.local.pid

cd /usr/local/mysql/data
Vinods-MacBook-Pro.log
```

#### MySQL Performance
* http://chrisgilligan.com/consulting/tuning-apache-and-mysql-for-best-performance-in-a-shared-virtual-hosting-environment/
* mysql performance guide
* https://www.digitalocean.com/community/tutorials/how-to-install-mysql-5-6-from-official-yum-repositories
* http://www.tocker.ca/2013/09/10/improving-mysqls-default-configuration.html

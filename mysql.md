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

Error log at data dir
```sh
usually /var/lib/mysql in a file named {host_name}.err
```

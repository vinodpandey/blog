mysql debugging
http://www.pontikis.net/blog/how-and-when-to-enable-mysql-logs  


To enable logs at runtime, login to mysql client (mysql -u root -p ) and give:
```sql
SET GLOBAL general_log = 'ON';
SET GLOBAL slow_query_log = 'ON';
```

To disable logs at runtime, login to mysql client (mysql -u root -p ) and give:
```sql
SET GLOBAL general_log = 'OFF';
SET GLOBAL slow_query_log = 'OFF';
```

Error log at data dir - usually /var/lib/mysql in a file named {host_name}.err

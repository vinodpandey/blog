Ref:
* http://blog.estl.moe/2016/08/16/pilot-your-infra-like-a-boss.html
* http://graphite.readthedocs.io/en/latest/install-virtualenv.html
* https://anomaly.io/install-graphite-centos/
* http://www.roblayton.com/2014/12/a-grafana-dashboard-for-graphite-and.html
* http://blog.airwoot.com/post/137688775104/monitoring-using-sensu-statsd-graphite-grafana
* https://ianunruh.com/2014/05/monitor-everything-part-4.html
* https://wiki.centos.org/HowTos/Https


# Architecture

sensu-server (using relay) -> carbon:2003  
Internet -> apache2:443 -> grafana:3000 -> apache2:8080 -> graphite-web  
Internet -> apache2:443 -> uchiwa:3001 -> sensu-api:4567  

# Base setup
### base softwares
```
sudo yum -y install git wget vim
```

### timezone to india
```
sudo ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
```

### semanage for managing permissions with selinux
```
sudo yum -y install policycoreutils-python setroubleshoot-server
# sudo sealert -a /var/log/audit/audit.log 
```

### enable remote connections on port 80 for httpd
```
sudo setsebool -P httpd_can_network_connect on
```

### System-wide File Descriptors (FD) Limits
```
sudo sysctl -w fs.file-max=100000
sudo vim /etc/sysctl.conf
fs.file-max = 100000

sudo sysctl fs.file-max

sudo vim /etc/security/limits.conf
 *       soft    nofile  65536
 *       hard    nofile  65536


Restart server for these changes to take effect
```

# Graphite and Carbon with sqlite database

### Installing alternate python 2.7.12
```
https://github.com/vinodpandey/scripts/blob/master/virtualenv-pip-python2.7.12.sh
```

### Apache with mod_wsgi (compiled with python 2.7.12), SSL and VirtualHost (for SSL)
```
sudo yum -y install httpd httpd-devel mod_ssl openssl

cd ~
# Self signed SSL certificate setup
# Generate private key 
openssl genrsa -out ca.key 2048 

# Generate CSR 
openssl req -new -key ca.key -out ca.csr

# Generate Self Signed Key
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

# Copy the files to the correct locations
sudo cp ca.crt /etc/pki/tls/certs
sudo cp ca.key /etc/pki/tls/private/ca.key
sudo cp ca.csr /etc/pki/tls/private/ca.csr

sudo restorecon -RvF /etc/pki

sudo vim +/SSLCertificateFile /etc/httpd/conf.d/ssl.conf
SSLCertificateFile /etc/pki/tls/certs/ca.crt
SSLCertificateKeyFile /etc/pki/tls/private/ca.key

sudo vim /etc/httpd/conf/httpd.conf
# add below line at end of file
NameVirtualHost *:443
NameVirtualHost *:8080
# change port to 8080
Listen 8080



sudo service httpd restart

if error in SSL vhost
sudo vim /etc/httpd/conf/httpd.conf 
Listen 443 http

# mod_wsgi installation
cd ~
wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.5.11.tar.gz
tar zxvf 4.5.11.tar.gz
cd mod_wsgi-4.5.11/
./configure --with-python=/usr/local/bin/python2.7
make
sudo make install
module location: /usr/lib64/httpd/modules/mod_wsgi.so

# start httpd on system restart
sudo chkconfig httpd on
```

### Installing Graphite
```
sudo yum -y install python-devel cairo-devel libffi-devel

sudo su
mkdir -p /opt/graphite
cd /opt/graphite
virtualenv-2.7 --no-site-packages .

source bin/activate

pip2.7 install https://github.com/graphite-project/whisper/tarball/master
pip2.7 install https://github.com/graphite-project/carbon/tarball/master
pip2.7 install https://github.com/graphite-project/graphite-web/tarball/master


## Configuring Graphite

PYTHONPATH=/opt/graphite/webapp django-admin.py migrate --settings=graphite.settings --run-syncdb
PYTHONPATH=/opt/graphite/webapp django-admin.py collectstatic --noinput --settings=graphite.settings
deactivate
# exit su shell
exit 

sudo chown -R apache:apache /opt/graphite/storage/
sudo chown -R apache:apache /opt/graphite/static/
sudo chown -R apache:apache /opt/graphite/webapp/

sudo semanage fcontext -a -t httpd_log_t "/opt/graphite/storage/log/webapp(/.*)?"  
sudo restorecon -RvF /opt/graphite/storage/log/  

# other selinux permissions

sudo setsebool -P httpd_execmem 1

sudo cp /opt/graphite/examples/example-graphite-vhost.conf /etc/httpd/conf.d/graphite-vhost.conf

sudo vim /etc/httpd/conf.d/graphite-vhost.conf
# update virtual host port
<VirtualHost *:8080>
# add below line after WSGISocketPrefix run/wsgi
WSGIPythonHome /opt/graphite

sudo cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi
sudo vim /opt/graphite/conf/graphite.wsgi
# Add below line in wsgi file
import site
site.addsitedir('/opt/graphite/lib/python2.7/site-packages')

sudo cp /opt/graphite/webapp/graphite/local_settings.py.example /opt/graphite/webapp/graphite/local_settings.py
sudo vim /opt/graphite/webapp/graphite/local_settings.py
# update below two keys
SECRET_KEY = 'salted_peanuts_hashed_browns'
TIME_ZONE = 'Asia/Kolkata'

sudo service httpd restart

logs
/opt/graphite/storage/log/

# checking access of local server 
/etc/hosts
127.0.0.1 graphite

wget http://graphite

# if any selinux related errors or application error
cd ~
sudo sealert -a /var/log/audit/audit.log  
sudo semodule -i mypol.pp

sudo service httpd restart
```

### configuring carbon
```
sudo cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
sudo cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf
sudo cp /opt/graphite/conf/storage-aggregation.conf.example /opt/graphite/conf/storage-aggregation.conf
sudo cp /opt/graphite/conf/relay-rules.conf.example /opt/graphite/conf/relay-rules.conf
sudo cp /opt/graphite/conf/aggregation-rules.conf.example /opt/graphite/conf/aggregation-rules.conf
sudo cp /opt/graphite/conf/rewrite-rules.conf.example /opt/graphite/conf/rewrite-rules.conf
sudo cp /opt/graphite/conf/blacklist.conf.example  /opt/graphite/conf/blacklist.conf 
sudo cp /opt/graphite/conf/whitelist.conf.example /opt/graphite/conf/whitelist.conf

sudo cp /opt/graphite/examples/init.d/carbon-* /etc/init.d/
sudo chmod +x /etc/init.d/carbon-*

sudo service carbon-cache start




## Troubleshooting
Check the carbon-cache log:
/opt/graphite/storage/log/carbon-cache/carbon-cache-a/console.log
/opt/graphite/storage/log/carbon-cache/carbon-cache-a/console.log

Check Graphite-WebApp log
/opt/graphite/storage/log/webapp/error.log

Check all process are running
ps aux | grep "carbon-ca\|httpd\|(wsgi:graphite)"

# start carbon-cache on system restart
sudo chkconfig --levels 235 carbon-cache on
```

# grafana
```
cd /usr/local/src
sudo yum -y install initscripts fontconfig
sudo wget https://grafanarel.s3.amazonaws.com/builds/grafana-4.0.2-1481203731.x86_64.rpm
sudo rpm -Uvh grafana-4.0.2-1481203731.x86_64.rpm

# To configure the Grafana server to start at boot time:
sudo /sbin/chkconfig --add grafana-server

sudo service grafana-server start

http://localhost:3000 
admin:admin

# https virtualhost
sudo vim /etc/httpd/conf.d/grafana.conf
<VirtualHost *:443>
         SSLEngine on
        SSLCertificateFile /etc/pki/tls/certs/ca.crt
        SSLCertificateKeyFile /etc/pki/tls/private/ca.key
        ServerName grafana.server.com
         ProxyPass / http://127.0.0.1:3000/ retry=0
         ProxyPassReverse / http://127.0.0.1:3000/

</VirtualHost>
sudo service httpd restart

# graphite integration
Menu > Data source > Add datasource
Name: graphite
Type: Graphite
Url: http://localhost:8080
Access: Proxy
Save & Test
Success message should be displayed

# change admin username, password and email
Admin > Profile - Information, Change Password


```

# sensu server with uchiwa
```
## redis (installing latest version as redis 2.4 has a hard-corded limit of handling multiple connections)
# update maximum number of file handles for a single process allowed to open from 1024 to 65535 
# https://sensuapp.org/docs/latest/installation/install-redis-on-rhel-centos.html
cd ~
sudo yum install -y tcl
wget http://download.redis.io/releases/redis-3.2.6.tar.gz
tar xzf redis-3.2.6.tar.gz
cd redis-3.2.6
make test
sudo make install
cd utils
# redis executable path - asked in below script - /usr/local/bin/redis-server
sudo ./install_server.sh 

# starting redis
sudo service redis_6379 start

# redis info
redis-cli info

# testing
redis-cli ping
PONG

## configuring redis

sudo vim /etc/sysctl.conf
vm.overcommit_memory=1
sudo sysctl vm.overcommit_memory=1
sudo sysctl -w fs.file-max=65536
```

## rabbit mq (erlang and rabbitmq server only, without management plugin)
```
https://github.com/vinodpandey/blog/tree/master/documentation/rabbitmq

sudo rabbitmqctl add_vhost /sensu
sudo rabbitmqctl add_user sensu secret
sudo rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

# delete guest account
sudo rabbitmqctl delete_user guest

# check file limits
sudo rabbitmqctl status | grep -A 4 file_descriptors
 {file_descriptors,[{total_limit,65436},
                    {total_used,2},
                    {sockets_limit,58890},
                    {sockets_used,0}]},
 {processes,[{limit,1048576},{used,137}]},

Ref: https://sensuapp.org/docs/latest/installation/install-rabbitmq-on-rhel-centos.html

## RabbitMQ SSL configuration for sensu 
sudo yum -y install openssl
cd ~
wget http://sensuapp.org/docs/0.25/files/sensu_ssl_tool.tar
tar -xvf sensu_ssl_tool.tar
cd sensu_ssl_tool
./ssl_certs.sh generate
ls -l

sudo mkdir -p /etc/rabbitmq/ssl/
sudo cp sensu_ca/cacert.pem /etc/rabbitmq/ssl/
sudo cp server/cert.pem /etc/rabbitmq/ssl/
sudo cp server/key.pem /etc/rabbitmq/ssl/

sudo service rabbitmq-server start 

sudo vim /etc/rabbitmq/rabbitmq.config
[
  {rabbit, [
     {ssl_listeners, [5671]},
     {ssl_options, [{cacertfile,"/etc/rabbitmq/ssl/cacert.pem"},
                    {certfile,"/etc/rabbitmq/ssl/cert.pem"},
                    {keyfile,"/etc/rabbitmq/ssl/key.pem"},
                    {versions, ['tlsv1.2']},
                    {ciphers,  [{rsa,aes_256_cbc,sha256}]},
                    {verify,verify_peer},
                    {fail_if_no_peer_cert,true}]}
   ]}
].

sudo service rabbitmq-server start

Ref: https://sensuapp.org/docs/0.25/reference/ssl.html
```


## sensu core installation
```
echo '[sensu]
name=sensu
baseurl=http://sensu.global.ssl.fastly.net/yum/$basearch/
gpgcheck=0
enabled=1' | sudo tee /etc/yum.repos.d/sensu.repo

sudo yum -y install sensu

#### sensu configuration
# redis
sudo vim /etc/sensu/conf.d/redis.json
{
  "redis": {
    "host": "127.0.0.1",
    "port": 6379
  }
}

# rabbitmq
## ssl client certificate copy
sudo mkdir -p /etc/sensu/ssl/
sudo cp client/cert.pem /etc/sensu/ssl/
sudo cp client/key.pem /etc/sensu/ssl/

sudo vim /etc/sensu/conf.d/rabbitmq.json
{
  "rabbitmq": {
    "host": "127.0.0.1",
    "port": 5671,
    "vhost": "/sensu",
    "user": "sensu",
    "password": "secret",
    "heartbeat": 30,
    "prefetch": 50,
    "ssl": {
      "cert_chain_file": "/etc/sensu/ssl/cert.pem",
      "private_key_file": "/etc/sensu/ssl/key.pem"
    }
 }
}


# transprt
sudo vim /etc/sensu/conf.d/transport.json
{
  "transport": {
    "name": "rabbitmq",
    "reconnect_on_error": true
  }
}

# api
sudo vim /etc/sensu/conf.d/api.json
{
  "api": {
    "host": "localhost",
    "bind": "0.0.0.0",
    "port": 4567
  }
}



# relay to carbon
sudo vim /etc/sensu/conf.d/relay.json
{
   "handlers": {
     "graphite_tcp": {
       "type": "tcp",
       "socket": {
         "host": "127.0.0.1",
         "port": 2003
       },
       "mutator": "only_check_output"
     }
   }
 }


sudo service sensu-server start
sudo service sensu-api start


# start on boot
sudo chkconfig sensu-server on
sudo chkconfig sensu-api on


Start or stop the Sensu Core API
sudo service sensu-api start
sudo service sensu-api stop

Start or stop the Sensu Core server
sudo service sensu-server start
sudo service sensu-server stop

Start or stop the Sensu client
sudo service sensu-client start
sudo service sensu-client stop
```
# uchiwa
```
sudo yum -y install uchiwa

sudo vim /etc/sensu/uchiwa.json
change port to 3001
delete Site 2 block
add localhost as host for Site 1

# setting password in uchiwa.json file
generate crypted password
openssl passwd -apr1 MY_PASSWORD

# add below key in "uchiwa"


"users": [
      {
        "username" : "admin",
        "password": "{crypt}$apr1$fNjfOV2X$pZ0wdlvsvmStsWtQRTAEL/",
        "readonly": false
      },
      {
        "username" : "guest",
        "password": "{crypt}$apr1$sjTWPHlh$nwprS4Duq1.ChlUALB4dr.",
        "readonly": true
      }
  ]


Ref: https://docs.uchiwa.io/getting-started/configuration/

sudo service uchiwa start

sudo chkconfig uchiwa on

## virtual host setting (on https)
sudo vim /etc/httpd/conf.d/uchiwa.conf

 <VirtualHost *:443>
        SSLEngine on
        SSLCertificateFile /etc/pki/tls/certs/ca.crt
        SSLCertificateKeyFile /etc/pki/tls/private/ca.key
        ServerName uchiwa.server.com
         ProxyPass / http://127.0.0.1:3001/
         ProxyPassReverse / http://127.0.0.1:3001/
 </VirtualHost>

sudo service httpd restart
```

## open ports 5671 and 443 for rabbitmq and https
```
sudo iptables -I INPUT -p tcp -m tcp --dport 5671 -j ACCEPT
sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
sudo service iptables save
```


# sensu client
```
## verify hostname is meaningful and not localhost.localdomain
hostname

updating hostname
sudo vim /etc/sysconfig/network
HOSTNAME=new.host.name

hostname new.host.name

# copy SSL keys
sudo mkdir -p /etc/sensu/ssl
copy cert.pem and key.pem to /etc/sensu/ssl/


echo '[sensu]
name=sensu
baseurl=http://sensu.global.ssl.fastly.net/yum/$basearch/
gpgcheck=0
enabled=1' | sudo tee /etc/yum.repos.d/sensu.repo

sudo yum -y install sensu

set safe_mode as true to check local definition also 

sudo vim /etc/sensu/conf.d/client.json
{
  "client": {
    "name": "client-1",
    "address": "192.168.0.151",
    "environment": "development",
    "safe_mode": true,
    "subscriptions": [
      "dev",
      "ubuntu"
    ],
    "socket": {
      "bind": "127.0.0.1",
      "port": 3030
    }
  }
}


# rabbitmq

sudo vim /etc/sensu/conf.d/rabbitmq.json
{
  "rabbitmq": {
    "host": "127.0.0.1",
    "port": 5671,
    "vhost": "/sensu",
    "user": "sensu",
    "password": "secret",
    "heartbeat": 30,
    "prefetch": 50,
    "ssl": {
      "cert_chain_file": "/etc/sensu/ssl/cert.pem",
      "private_key_file": "/etc/sensu/ssl/key.pem"
    }
 }
}



sudo vim /etc/sensu/conf.d/transport.json
{
  "transport": {
    "name": "rabbitmq",
    "reconnect_on_error": true
  }
}




Start or stop the Sensu client
sudo service sensu-client start
sudo service sensu-client stop
```

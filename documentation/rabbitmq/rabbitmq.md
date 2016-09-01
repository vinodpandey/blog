
## Install and enable EPEL repository
```sh
sudo yum -y install epel-release
sudo yum repolist

Loaded plugins: fastestmirror, refresh-packagekit, replace, security
Loading mirror speeds from cached hostfile
 * base: mirror.nbrc.ac.in
 * epel: epel.mirror.angkasa.id
 * extras: mirror.nbrc.ac.in
 * ius: hkg.mirror.rackspace.com
 * updates: mirror.nbrc.ac.in
repo id   repo name                                        status
base      CentOS-6 - Base                                  6,696
epel      Extra Packages for Enterprise Linux 6 - x86_64   12,201
extras    CentOS-6 - Extras                                62
```

## Install erlang (zero-dependency Erlang from RabbitMQ)
```sh
cd /usr/local/src
sudo wget http://www.rabbitmq.com/releases/erlang/erlang-19.0.4-1.el6.x86_64.rpm
sudo yum -y install erlang-19.0.4-1.el6.x86_64.rpm
```

## RabbitMQ installation
```sh
cd /usr/local/src
sudo wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.5/rabbitmq-server-3.6.5-1.noarch.rpm 
sudo rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
sudo yum -y install rabbitmq-server-3.6.5-1.noarch.rpm

sudo service rabbitmq-server status
Status of node rabbit@localhost ...
[{pid,1041},
 {running_applications,
     [{rabbitmq_management,"RabbitMQ Management Console","3.6.5"},

```

## Managing RabbitMQ
```sh
# Start server on system boot
sudo chkconfig rabbitmq-server on

# Running RabbitMQ Server
sudo service rabbitmq-server start/stop/status

# Managing the Broker
sudo rabbitmqctl status/stop

# Logging
/var/log/rabbitmq
```

## Enabling managment plugin (on https)
```sh
sudo rabbitmq-plugins enable rabbitmq_management

mkdir -p /etc/rabbitmq/ssl/
cd /etc/rabbitmq/ssl/
# for development server, use below command to create self signed certificate
# answer all the questions with dummy data while generating key
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/rabbitmq/ssl/ca.key -out /etc/rabbitmq/ssl/ca.crt

sudo vim /etc/rabbitmq/rabbitmq.config
[{rabbitmq_management,
  [{listener, [{port,     15672},
               {ssl,      true},
               {ssl_opts, [{cacertfile, "/etc/rabbitmq/ssl/ca.crt"},
                           {certfile,   "/etc/rabbitmq/ssl/ca.crt"},
                           {keyfile,    "/etc/rabbitmq/ssl/ca.key"}]}
              ]}
  ]}
].

sudo rabbitmqctl stop
sudo service rabbitmq-server start
```

## Adding new admin
```sh
rabbitmqctl add_user newadmin {password}
rabbitmqctl set_user_tags newadmin administrator
rabbitmqctl set_permissions -p / newadmin ".*" ".*" ".*"


http://server-name:15672/ (guest/guest)
```

## Deleting guest user
```sh
http://server-name:15672/ (guest/guest)
Home > Admin
```



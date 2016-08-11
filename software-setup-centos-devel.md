## Software Setup
* Apache
* MySQL
* PHP
* phpMyAdmin
* Python

WARNING: Below configurations are for development server only and should never be used in production.

#### Switch to root user
```sh
sudo su
```

#### Basic software installation
```sh
sudo yum install -y wget vim git memcached gcc libffi-devel python-devel openssl-devel java  
```

#### Enable epel repo
```sh
sudo su
cd /usr/local/src
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh epel-release-latest-6.noarch.rpm
```

#### Apache
```sh
yum -y install httpd
# Changing port to 8080
vim /etc/httpd/conf/httpd.conf
Listen 8080
service httpd restart
```

#### PHP
```sh
yum -y install php php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml
# upgrading tp php 5.5
cd /usr/local/src
wget https://centos6.iuscommunity.org/ius-release.rpm
rpm -Uvh ius-release*.rpm
yum -y install yum-plugin-replace
# below command may show warning that some packages are not matched. Ignore that and press y
yum replace php --replace-with php55u
```

#### MySQL
```sh
# Uninstall previous version of MySQL
service mysqld stop
yum list installed | grep mysql
# remove all packages listed above. similar to below command
yum remove mysql-client mysql-server mysql-common mysql-devel
rm -rf /var/lib/mysql/
rm -rf /etc/my.cnf

# Enable mysql repo
cd /usr/local/src
wget https://dev.mysql.com/get/mysql57-community-release-el6-8.noarch.rpm
yum -y localinstall mysql57-community-release-el6-8.noarch.rpm

vim /etc/yum.repos.d/mysql-community.repo
make below changes
# Enable to use MySQL 5.6
enabled=1
# Enable to use MySQL 5.7
enabled=0

yum -y install mysql-server mysql-devel libffi-devel
service mysqld start
mysql_secure_installation
Enter current password for root (enter for none): Press Enter
Set root password? [Y/n] Y
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y

# verify the new password is working properly
mysql -uroot -p
```

#### phpMyAdmin
```sh
yum -y install phpmyadmin
# enable localhost access
sudo vim /etc/httpd/conf.d/phpMyAdmin.conf
comment out all RequireAny
and change 
Deny from All
to 
Allow from All

sudo /etc/init.d/httpd restart
Access: http://localhost:8080/phpmyadmin
```

#### Python 2.7.10
```sh
cd /usr/local/src
wget --no-check-certificate -O virtualenv-pip-python2.7.10.sh https://raw.github.com/vinodpandey/scripts/master/virtualenv-pip-python2.7.10.sh  
chmod +x virtualenv-pip-python2.7.10.sh  
./virtualenv-pip-python2.7.10.sh 
python2.7 -V 
```

#### Enable services to autostart on desktop restart
```sh
/etc/init.d/httpd start
/etc/init.d/memcached 
/etc/init.d/mysqld start
chkconfig --level 345 memcached on
chkconfig --level 345 mysqld on
chkconfig --level 345 httpd on
```

#### timezone setup
```sh
ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
```

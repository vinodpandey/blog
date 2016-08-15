## Software Setup
* Apache
* MySQL
* PHP
* phpMyAdmin
* Python
* Memcache
* NodeJS
* Chrome
* SSH key in bitbucket

WARNING: Below configurations are for development server only and should never be used in production.

#### Creating a bootable CentOS USB
```sh
Download iso file (http://ftp.iitm.ac.in/centos/6.8/isos/x86_64/CentOS-6.8-x86_64-bin-DVD1.iso)
Use http://iso2usb.sourceforge.net/ to create bootable usb
Create free space on desktop for installing CentOS
Use USB to boot and install 
```

#### Adding user to sudoers
```sh
su
visudo -f /etc/sudoers
uncomment - 
# %wheel ALL=(ALL)   NOPASSWD:ALL
usermod -a -G wheel username

# logout and login again
# to test
sudo ls
```

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

chkconfig --level 345 httpd on

httpd -v
Server version: Apache/2.2.15 (Unix)
Server built:   Jul 18 2016 15:24:00
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

php -v
PHP 5.5.38 (cli) (built: Jul 21 2016 14:12:41) 
Copyright (c) 1997-2015 The PHP Group
Zend Engine v2.5.0, Copyright (c) 1998-2015 Zend Technologies
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

yum -y install mysql mysql-server mysql-devel libffi-devel
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

mysql -V
mysql  Ver 14.14 Distrib 5.6.32, for Linux (x86_64) using  EditLine wrapper

chkconfig --level 345 mysqld on

```

#### phpMyAdmin
```sh
yum -y install phpmyadmin
# enable localhost access
sudo vim /etc/httpd/conf.d/phpMyAdmin.conf

change 
Deny from All
to 
Allow from All

<Directory /usr/share/phpMyAdmin/>

</Directory>

<Directory /usr/share/phpMyAdmin/setup/>

</Directory>

service httpd restart
Access: http://localhost:8080/phpmyadmin
```

#### Python 2.7.10
```sh
cd /usr/local/src
wget --no-check-certificate -O virtualenv-pip-python2.7.10.sh https://raw.github.com/vinodpandey/scripts/master/virtualenv-pip-python2.7.10.sh  
chmod +x virtualenv-pip-python2.7.10.sh  
./virtualenv-pip-python2.7.10.sh 
python2.7 -V 
Python 2.7.10
```

#### Installing memcached
```sh
yum -y install memcached
service memcached start
chkconfig --level 345 memcached on

```

#### Installing NodeJS
```sh
yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
node -v
v6.3.1
npm -v
3.10.3
npm install -g gulp-cli bower
```

#### Installing Chrome
```sh
cd /usr/local/src
wget http://chrome.richardlloyd.org.uk/install_chrome.sh
sudo bash install_chrome.sh

To update Google Chrome, run "yum update google-chrome-stable" or
simply re-run this script with "./install_chrome.sh".

To uninstall Google Chrome and its dependencies added by this script,
run "yum remove google-chrome-stable chrome-deps-stable" or "./install_chrome.sh -u".
```

#### timezone setup
```sh
ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
```

#### SSH in bitbucket
```sh
ls -al ~/.ssh
# Lists the files in your .ssh directory, if they exist
# Use below command to generate SSH key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

cat ~/.ssh/id_rsa.pub
# in MacOSX
pbcopy < ~/.ssh/id_rsa.pub
# copy the key in account profile in bitbucket
```

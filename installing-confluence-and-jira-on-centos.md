
installing-confluence-and-jira-on-centos  
============================================  

copying setup files to server  
------------------------------  
scp -rv atlassian-confluence-5.6.6-x64.bin root@192.168.33.12:/opt/  
scp -rv atlassian-jira-software-7.1.7-jira-7.1.7-x64.bin root@192.168.33.12:/opt/  

installing java  
----------------  
verify if java already installed and JAVA_HOME is set  
```sh
java -version  
echo $JAVA_HOME  
```

installing java  
```sh
sudo yum install java-1.7.0-openjdk-devel  
```

setting up JAVA_HOME  
```sh
# find java install location   
update-alternatives --display java  
/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java  

cd /etc/profile.d  
vim java_home.sh  
export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64  
close and reopen terminal for changes to take effect
echo $JAVA_HOME
```



insalling jira  
---------------  
```sh
sudo chmod a+x atlassian-jira-software-7.1.7-jira-7.1.7-x64.bin
sudo ./atlassian-jira-software-7.1.7-jira-7.1.7-x64.bin 
o, Enter  
2, Enter (Custom install)  
install location: /opt/atlassian/jira  
data location: /var/atlassian/application-data/jira  
2 - custom ports  
HTTP - 8090  
Control port - 8095  
y, Enter - JIRA as a service  
i, Enter
```

setup mysql drivers  
--------------------  
```sh
# stop jira server  
cd /opt/atlassian/jira/bin  
sudo -u jira bash  
./stop-jira.sh  
exit 

cd /opt/  
sudo wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.tar.gz  
sudo tar zxvf mysql-connector-java-5.1.34.tar.gz  
sudo cp mysql-connector-java-5.1.34/mysql-connector-java-5.1.34-bin.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/  

start jira server 
cd /opt/atlassian/jira/bin  
sudo -u jira bash  
./start-jira.sh 
```

post installation steps  
------------------------  
```sh
access - http://192.168.33.12:8090/  
I'll set it up myself - Next  
My own database  
Enter mysql database details  
Test Connection  
Next  
Mode: Private  
Update Base URL: subdomain.domain.com  
Next  
JIRA + JIRA Agile  
Add licence  
Setup admin account  
Setup email notification later  
```

starting/stoppin jira server  
-----------------------------  
```sh
custom wizard creates default user - jira - for running server  
cd /opt/atlassian/jira/bin  
sudo -u jira bash  
./stop-jira.sh  
./start-jira.sh  
```

insalling confluence  
---------------------  
sudo chmod a+x atlassian-confluence-5.6.6-x64.bin  
sudo ./atlassian-confluence-5.6.6-x64.bin  
o, Enter  
2, Enter (Custom install)  
instal location: /opt/atlassian/jira  
data location: /var/atlassian/application-data/jira  
2 - custom ports  
HTTP - 8081  
Control port - 8086  
y, Enter - Confluence as a service  

starting/stoppin confluence server  
----------------------------------  
custom wizard creates default user - confluence - for running server  
cd /opt/atlassian/confluence/bin  
sudo -u confluence bash  
./stop-confluence.sh  
./start-confluence.sh  

setup mysql drivers  
--------------------  
stop confluence server  
cd /opt/  
sudo wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.tar.gz  
sudo tar zxvf mysql-connector-java-5.1.34.tar.gz  
sudo cp mysql-connector-java-5.1.34/mysql-connector-java-5.1.34-bin.jar /opt/atlassian/confluence/confluence/WEB-INF/lib/  

start confluence server  

changing ports manually (seems custom wizard is not updating the ports)  
------------------------------------------------------------------------  
stop confluence server  
sudo vim /opt/atlassian/confluence/conf/server.xml  
change ports - 8081, 8086  
start confleunce server   

post installation configuration  
-----------------------------------  
access http://192.168.33.12:8086/  
production setup  
genrerate evalutation key  
Next  
External database - MySQL  
Direct JDBC  
Example site  

bin/setenv.sh contains the heap memory setting   


Common Erros:  
SEVERE: Unable to create directory for deployment: /opt/atlassian/confluence/conf/Standalone/localhost  

change permissions: sudo chown confluence:confluence conf  


setting proxy on cpanel (with existing domain - example.com)
------------------------------------------------------------
Apache Configuration > Include Editor > Post Virtual Host Include

<VirtualHost xx.xx.xx.xx:80>
  ServerName jira.example.com
	ProxyPass / http://localhost:8080/
	ProxyPassReverse / http://localhost:8080/
	ProxyPreserveHost On
	RequestHeader set X-Forwarded-Proto "https" env=HTTPS
</VirtualHost>

<VirtualHost xx.xx.xx.xx:80>
  ServerName confluence.example.com
	ProxyPass / http://localhost:8081/
	ProxyPassReverse / http://localhost:8081/
	ProxyPreserveHost On
	RequestHeader set X-Forwarded-Proto "https" env=HTTPS
</VirtualHost>







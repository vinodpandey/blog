# installing gatling on centos
## install java 1.8
Ref: http://tecadmin.net/install-java-8-on-centos-rhel-and-fedora/

```sh
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz"

tar xzf jdk-8u91-linux-x64.tar.gz

alternatives --install /usr/bin/java java /opt/jdk1.8.0_91/bin/java 2
alternatives --config java


There are 3 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
*  1           /opt/jdk1.7.0_71/bin/java
 + 2           /opt/jdk1.8.0_45/bin/java
   3           /opt/jdk1.8.0_77/bin/java
   4           /opt/jdk1.8.0_91/bin/java

Enter to keep the current selection[+], or type selection number: 

alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_91/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_91/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_91/bin/jar
alternatives --set javac /opt/jdk1.8.0_91/bin/javac

java -version
```
## installing gatling
```sh
cd /opt/
wget https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/2.2.2/gatling-charts-highcharts-bundle-2.2.2-bundle.zip
unzip gatling-charts-highcharts-bundle-2.2.2-bundle.zip 

./gatling.sh
simulation are in user-files directory  
```

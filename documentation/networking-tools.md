#### tcpdump
```sh
yum -y install tcpdump
tcpdump -n port mysql

# analyze last 100 data packets
tcpdump -ni eth0 -c 100
```
* https://danielmiessler.com/study/tcpdump/

#### netstat
```sh
netstat -lnp | grep mysql
netstat -na | grep -i list
telnet localhost 3306
```

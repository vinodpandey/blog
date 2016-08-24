#### tcpdump
```sh
yum -y install tcpdump
tcpdump -n port mysql
```
* https://danielmiessler.com/study/tcpdump/

#### netstat
```sh
netstat -lnp | grep mysql
netstat -na | grep -i list
telnet localhost 3306
```

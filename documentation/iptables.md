
#### Opening Port
```sh
# opening port for specific address
iptables -I INPUT -i eth0 -p tcp -s 172.16.100.0/24 --destination-port 3306 -j ACCEPT
service iptables save
# opening port for all
iptables -I INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT
service iptables save
```

#### Deleting Rule
```sh
sudo iptables -L --line-numbers  
sudo iptables -D INPUT 3  
```

#### Links
* https://www.digitalocean.com/community/tutorials/how-to-list-and-delete-iptables-firewall-rules


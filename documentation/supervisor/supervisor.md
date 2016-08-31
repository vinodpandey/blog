## Installation
```sh
sudo pip2.7 install supervisor
sudo ln -sfn /usr/local/bin/supervisord /usr/bin/supervisord
sudo mkdir -p /var/log/gunicorn/
```

## Config file
```sh
echo_supervisord_conf > supervisord.conf
sudo mv supervisord.conf /etc/
```

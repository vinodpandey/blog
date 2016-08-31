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

## Gunicorn & Django
```sh
[program:gunicorn_project]
command=/home/user/virtualenv/bin/python2.7 /home/user/virtualenv/bin/gunicorn project.prod_wsgi:application --timeout 120 --bind=0.0.0.0:8000 --workers 17
directory=/home/user/virtualenv/project
user=apache
autostart=true
autorestart=true
stdout_logfile = /var/log/gunicorn/project-std.log
stderr_logfile = /var/log/gunicorn/project-err.log
```



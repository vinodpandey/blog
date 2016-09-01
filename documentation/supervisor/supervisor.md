## Installation
```sh
sudo pip2.7 install supervisor
(to setup pip2.7 https://github.com/vinodpandey/scripts/blob/master/virtualenv-pip-python2.7.10.sh)
sudo ln -sfn /usr/local/bin/supervisord /usr/bin/supervisord
sudo ln -sfn /usr/local/bin/supervisorctl /usr/bin/supervisorctl  
sudo mkdir -p /var/log/gunicorn/
```

## Config file
```sh
echo_supervisord_conf > supervisord.conf
sudo mv supervisord.conf /etc/
```

## Managing 
```sh
# start  
sudo /usr/bin/supervisord -c /etc/supervisord.conf 

#stop
sudo supervisorctl shutdown

# status  
sudo supervisorctl status  

sudo supervisorctl start gunicorn_website  
sudo supervisorctl stop gunicorn_website
ps aux | grep gunicorn_website
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

## Celery & Django
```sh
sudo mkdir -p /var/log/celery

[program:celeryd]
command=/home/user/virtualenv/bin/celery worker -A project --loglevel=INFO
directory=/home/user/virtualenv/project
user=nobody
numprocs=1
stdout_logfile=/var/log/celery/celeryd-std.log
stderr_logfile=/var/log/celery/celeryd-err.log
autostart=true
autorestart=true
startsecs=10
stopwaitsecs = 600
killasgroup=true
```

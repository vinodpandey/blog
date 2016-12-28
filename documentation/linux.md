
#### One liners
```sh
# running last command as superuser
sudo !!
```

#### copying files with permission from one directory to another
```
# install if command not available
yum -y install rsync

# remember to keep the trailing slash for it to copy inside content as it is and not create source folder again
rsync -avzh /root/rpmpkgs /tmp/backups/

```

### spidering a website
```sh
wget --spider --recursive --verbose --output-file=wgetlog.txt http://localhost/downloads/
```
### spidering only a section
```sh
wget --spider --recursive --verbose --no-parent --output-file=wgetlog.txt http://localhost/downloads/
```


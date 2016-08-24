#### Clear complete cache
```sh
varnishadm "ban req.url ~ ."
```
#### logging
```sh
varnishlog
# for testing a particular request
varnishlog | grep "request url path"
```

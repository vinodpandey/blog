#### Clear complete cache
```sh
varnishadm "ban req.url ~ ."
```
#### logging
```sh
varnishlog
# for testing a particular request
varnishlog | grep "rquest url path"
```

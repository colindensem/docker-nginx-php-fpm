# php-fpm
Docker, Debian base, PHP-FPM, listening on 9000 for work.

Core PHP packages are:
```
php5-apcu, php5-cli, php5-curl, php5-fpm,
php5-json, php5-gd, php5-intl, php5-imagick,
php5-imap, php5-mcrypt, php5-memcache, php5-mysql, php5-redis
```

## To Build

```
$ docker build -t=colindensem/php-fpm -rm=true .
```

## To Run

```
$ docker run -i -p 9000:9000 colindensem/php-fpm
```


## Next Steps
This is intended to use this image as a base for other projects to build upon. In that sense, it possibly does to much already, i.e. begins configuration tasks.

At this point it is usable to develop against for php sites. You will need to add modules/ini settings for your needs.

You probabbly need a static assets handler to proxy to this https://github.com/colindensem/docker-nginx-proxy-php


## TODO

  * Handle logging, both rotation and logs output i.e.  [Automating Docker Logging: ElasticSearch, Logstash, Kibana, and Logspout](http://nathanleclaire.com/blog/2015/04/27/automating-docker-logging-elasticsearch-logstash-kibana-and-logspout/)

### Credits
Multiple other docker file authors, every talk, example and gist.

### License
MIT License.

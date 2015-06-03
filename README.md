# nginx-php-fpm
Docker, Ubuntu base, NGINX, PHP-FPM running with supervisor. Sourcing NGINX from the nginx repository.

Core PHP packages are:
```
php5-apcu, php5-cli, php5-curl, php5-fpm,
php5-json, php5-gd, php5-intl, php5-imagick,
php5-imap, php5-mcrypt, php5-memcache, php5-mysql, php5-redis
```

## To Build

```
$ docker build -t=colindensem/nginx-php-fpm -rm=true .
```

## To Run

```
$ docker run -i -p 8080:80 colindensem/nginx-php-fpm
```

Go to http://127.0.0.1:8080, if using boot2docker, replace ip accordingly.

If successful you will see a phpinfo() output.

## Next Steps
This is intended to use this image as a base for other projects to build upon. In that sense, it possibly does to much already, i.e. begins configuration tasks.

At this point it is usable to develop against for php sites. You will need to add modules/ini settings for your needs.

NGINX is configured to look for files in /srv/application/public.

You need to map your application to that directory.
There are two ONBUILD hooks, these will run when you use this in another build, e.g. your project for a static page.

```
ONBUILD ADD ./application /srv/application
ONBUILD RUN chown -Rf www-data.www-data /srv/application
```

These will be run early on.  For development, you can launch using the volumes flag -v

```
$ docker run -i -p 8080:80 -v \
 /home/user/workspace/project:/srv/http/application \
 --name project \
 colindensem/nginx-php-fpm
```

## TODO

  * Handle logging, both rotation and logs output i.e.  [Automating Docker Logging: ElasticSearch, Logstash, Kibana, and Logspout](http://nathanleclaire.com/blog/2015/04/27/automating-docker-logging-elasticsearch-logstash-kibana-and-logspout/)

### Credits
Multiple other docker file authors, every talk, example and gist.

### License
MIT License.

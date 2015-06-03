FROM colindensem/nginx
MAINTAINER Colin Densem "hello@summit360.co.uk"
#!! BUILD TRIGGERS
#   colindensem/nginx uses onbuild to ADD application folder.

# Add dotdeb for extra php support packages, e.g. redis, php5.6 etc
RUN wget http://www.dotdeb.org/dotdeb.gpg && \
    apt-key add dotdeb.gpg
RUN echo deb http://packages.dotdeb.org wheezy-php56-zts all >> /etc/apt/sources.list.d/dotdeb.list
RUN echo deb-src http://packages.dotdeb.org wheezy-php56-zts all >> /etc/apt/sources.list.d/dotdeb.list

# System update & upgrade
RUN apt-get update && apt-get dist-upgrade -y

# Install PHP5 Packages
RUN apt-get install -y \
  php5-apcu \
  php5-cli \
  php5-curl \
  php5-fpm \
  php5-json \
  php5-gd \
  php5-intl \
  php5-imagick \
  php5-imap \
  php5-mcrypt \
  php5-memcache \
  php5-mysql \
  php5-redis

# Create required directories
RUN mkdir -p /var/run/php5-fpm

# Configure NGINX.CONF vhost
ADD ./config/nginx/sites-enabled /etc/nginx/sites-enabled

# SUPERVISOR Config
ADD ./config/supervisord.conf /etc/supervisord.conf

# Add additonal nginx config
ADD ./config/nginx/*.conf /etc/nginx/

# Configure PHP && PHP-FPM.CONF
ADD ./config/php/pool-app.conf /etc/php5/fpm/pool.d/www.conf
ADD ./config/php/php.ini /etc/php5/fpm/php.ini
ADD ./config/php/custom.ini /etc/php5/fpm/conf.d/40-custom.ini

RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf


# Add Application Code ! Will be overridden by other applications !
ONBUILD ADD ./application /srv/application
ONBUILD RUN chown -Rf www-data.www-data /srv/application

# EXPOSE
EXPOSE 80



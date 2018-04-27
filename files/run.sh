#!/bin/sh

[ -f /run-pre.sh ] && /run-pre.sh

#chown -R nginx:nginx /DATA

if [ ! -d /DATA/html ] ; then
  mkdir -p /DATA/html
fi
chown nginx:nginx /DATA/html


# start php-fpm
mkdir -p /DATA/logs/php-fpm
# start nginx
mkdir -p /DATA/logs/nginx
mkdir -p /tmp/nginx
chown nginx:nginx /tmp/nginx
#chown -R nginx:nginx /DATA
mkdir -p /DATA/sessions
chown nginx:nginx /DATA/sessions
chown nginx:nginx -R  /DATA/logs



if [ ! -d /DATA/bin ] ; then
  mkdir /DATA/bin
  chown nginx:nginx /DATA/bin
  cp /usr/bin/wp /DATA/bin/wp-cli

  #curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  #chmod +x wp-cli.phar 
  #mv wp-cli.phar /DATA/bin/wp-cli 
fi


redis-server /etc/redis.conf
php-fpm -D
nginx
tail -f /dev/null

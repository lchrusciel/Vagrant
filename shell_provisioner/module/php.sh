#!/bin/bash

# PHP

apt-get -y install php7.0-cli php7.0-fpm php7.0-dev php7.0-curl php7.0-intl \
    php7.0-mysql php7.0-sqlite3 php7.0-gd php7.0-mbstring php7.0-xml php7.0-xdebug

sed -i 's/;date.timezone.*/date.timezone = Europe\/Brussels/' /etc/php/7.0/fpm/php.ini
sed -i 's/;date.timezone.*/date.timezone = Europe\/Brussels/' /etc/php/7.0/cli/php.ini
sed -i 's/^user = www-data/user = vagrant/' /etc/php/7.0/fpm/pool.d/www.conf
sed -i 's/^group = www-data/group = vagrant/' /etc/php/7.0/fpm/pool.d/www.conf

sed -i 's/zend_extension=xdebug.so/; zend_extension=xdebug.so/g' /etc/php/7.0/cli/conf.d/20-xdebug.ini

# 10.0.2.2 is a default ip address from vagrant to computer. If any problem appear please use netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10 to check if it is a proper value
cat << EOF >> /etc/php/7.0/cli/conf.d/20-xdebug.ini
xdebug.max_nesting_level = 5000

xdebug.remote_autostart=1
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_mode=req
xdebug.remote_host=10.0.2.2
xdebug.remote_port=9000

xdebug.idekey=PHPSTORM
EOF

service php7.0-fpm restart

# composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
ln -s /usr/bin/composer.phar /usr/bin/composer

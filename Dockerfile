FROM j33r/php-fpm:latest

LABEL name="docker-php-fpm" \
      maintainer="Jee jee@jeer.fr" \
      description="PHP is a popular general-purpose scripting language that is especially suited to web development." \
      url="https://www.php.net" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-php-fpm"

RUN apk update && \
    apk upgrade && \
    cd /tmp && \
    SIG_CHECKSUM="$(wget -O - https://composer.github.io/installer.sig)" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    COMPOSER_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" && \
    if [ "$SIG_CHECKSUM" != "$COMPOSER_CHECKSUM" ]; then \
        echo 'ERROR: Invalid installer checksum' \
        rm /tmp/composer-setup.php; \
        exit 1; \
    fi && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('/tmp/composer-setup.php');" && \
    rm -rf /tmp/*

WORKDIR /app

STOPSIGNAL SIGQUIT
VOLUME ["/php", "/app"]
ENTRYPOINT ["/usr/sbin/php-fpm7", "-y", "/etc/php7/php-fpm.conf"]

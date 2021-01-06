FROM j33r/php-fpm:composer

LABEL name="docker-php-fpm" \
      maintainer="Jee jee@jeer.fr" \
      description="PHP is a popular general-purpose scripting language that is especially suited to web development." \
      url="https://www.php.net" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-php-fpm"

RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache \
        nodejs \
        npm && \
    npm install -g yarn && \
    cd /tmp && \
    wget https://get.symfony.com/cli/installer -O - | bash && \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony && \
    ln -s /usr/local/bin/symfony /usr/local/bin/symfony-cmd && \
    rm -rf /tmp/*

WORKDIR /app

STOPSIGNAL SIGQUIT
VOLUME ["/php", "/app"]
ENTRYPOINT ["/usr/sbin/php-fpm7", "-y", "/etc/php7/php-fpm.conf"]

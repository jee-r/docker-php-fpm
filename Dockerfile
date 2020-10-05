FROM alpine:3.12

LABEL name="docker-php-fpm" \
      maintainer="Jee jee@jeer.fr" \
      description="PHP is a popular general-purpose scripting language that is especially suited to web development." \
      url="https://www.php.net" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-php-fpm"


ARG UID=${UID:-1000}
ARG GID=${GID:-1000}
ARG USER_NAME=${USER_NAME:-php}
ARG GROUP_NAME=${GROUP_NAME:-php}

COPY php-fpm.conf /etc/php7/php-fpm.conf

RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache \
      git \
      bash \
      curl \
      tzdata \
      php7 \
      php7-fpm \
      php7-curl \
      php7-gmp \
      php7-intl \
      php7-mbstring \
      php7-xml \
      php7-zip \
      php7-ctype \
      php7-dom \
      php7-fileinfo \
      php7-iconv \
      php7-json \
      php7-opcache \
      php7-phar \
      php7-session \
      php7-simplexml \
      php7-xmlreader \
      php7-xmlwriter \
      php7-tokenizer \
      php7-zlib \
      php7-pdo_sqlite \
      php7-pdo_mysql \
      php7-pdo_pgsql && \
      echo "Create user ${USER_NAME} with uid:${UID} and group with gid:${GID} ..." && \
    if [ "$(grep ':'${GID}':' /etc/group)" == "" ]; then \
      addgroup -g ${GID} ${GROUP_NAME}; \
    else \
      GROUP_NAME=$(grep ':'${GID}':' /etc/group | cut -d: -f1); \
    fi && \
    if [ "$(grep ${UID} /etc/passwd)" == "" ]; then \
      adduser -h /app -s /bin/sh -G ${GROUP_NAME} -D -u ${UID} ${USER_NAME}; \
    fi && \
    mkdir -p /php && \
    mkdir -p /app/cron && \
    chown -R ${UID}:${GID} /php /app

WORKDIR /app
USER $USER_NAME:$GROUP_NAME

STOPSIGNAL SIGQUIT
VOLUME ["/php", "/app"]
ENTRYPOINT ["/usr/sbin/php-fpm7", "-y", "/etc/php7/php-fpm.conf"]

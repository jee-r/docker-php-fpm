# docker-php-fpm
[![Drone (cloud)](https://img.shields.io/drone/build/jee-r/docker-php-fpm?style=flat-square)](https://cloud.drone.io/jee-r/docker-php-fpm)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/php-fpm?style=flat-square)](https://microbadger.com/images/j33r/php-fpm)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/j33r/php-fpm?style=flat-square)](https://microbadger.com/images/j33r/php-fpm)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/php-fpm?style=flat-square)](https://hub.docker.com/r/j33r/php-fpm)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/php-fpm%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/php-fpm)

A docker image for [php](https://www.php.net) ![php's logo](https://i.imgur.com/Sr3jtFC.png)


```

version: "3.8"

services:
  php:
    image: j33r/php-fpm:latest
    #container_name: php-fpm
    user: "${UID:-1000}:${GID:-1000}"
    restart: unless-stopped
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./php-fpm.conf:/etc/php7/php-fpm.conf
      - ./php_custom.ini:/etc/php7/conf.d/00_custom.ini
      #- ./build/php-fpm/phpinfo.php:/app/index.php
      - ./:/app
      - php:/php
      #- app:/app

```

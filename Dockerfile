ARG PHP_VERSION=8.2
ARG COMPOSER_VERSION=2.2

FROM composer:${COMPOSER_VERSION} AS composer
FROM php:${PHP_VERSION}-cli

ARG TARGETOS TARGETARCH
ARG NODE_VERSION=22.11.0

COPY --from=composer /usr/bin/composer /usr/bin/composer

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions gd intl pdo_mysql zip


RUN cd /opt && \
    if [ "$TARGETARCH" = "arm64" ]; then TARGETARCH="arm64"; else TARGETARCH="x64"; fi && \
    curl -LO "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${TARGETOS}-${TARGETARCH}.tar.xz" && \
    tar -xJf "node-v${NODE_VERSION}-${TARGETOS}-${TARGETARCH}.tar.xz" && \
    rm "node-v${NODE_VERSION}-${TARGETOS}-${TARGETARCH}.tar.xz" && \
    ln -s "/opt/node-v${NODE_VERSION}-${TARGETOS}-${TARGETARCH}/bin/node" /usr/local/bin/node && \
    ln -s "/opt/node-v${NODE_VERSION}-${TARGETOS}-${TARGETARCH}/bin/npm" /usr/local/bin/npm && \
    ln -s "/opt/node-v${NODE_VERSION}-${TARGETOS}-${TARGETARCH}/bin/npx" /usr/local/bin/npx && \
    ln -s "/opt/node-v${NODE_VERSION}-${TARGETOS}-${TARGETARCH}/bin/corepack" /usr/local/bin/corepack

RUN mkdir /app

WORKDIR /app
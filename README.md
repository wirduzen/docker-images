# WIRDUZEN Docker images

This repository builds some base docker images used for CI/CD purposes.

## Software

The images include the following software:

- PHP
- Composer
- NodeJS (and NPM)
- Shopware-CLI

## Build Args

By default the GitHub Actions will build the most common combinations of 
PHP and NodeJS versions. You can provide build args to control which
versions will be included.

| Arg              | Description                             | Example Value |
| ---------------- | --------------------------------------- | ------------- |
| PHP_VERSION      | PHP Version to include in image         | 8.2           |
| NODE_VERSION     | Full NodeJS Version to include in image | 22.11.0       |
| COMPOSER_VERSION | Composer version to install in image    | 2.2           |

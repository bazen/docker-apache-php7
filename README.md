apache-php7
===================================

A Docker image based on Ubuntu 18.04, serving PHP 7.2 running as Apache Module. Useful for Web developers in need for a fixed PHP version. In addition, the `error_reporting` setting in php.ini is configurable per container via environment variable.

Tags
-----

* latest: Ubuntu 18.04 (LTS), Apache 2.4, PHP 7.2.x with support for setting `error_reporting`

Usage
------

```
$ docker run -d -P bazen/apache-php7
```

With all the options:

```bash
$ docker run -d -p 8080:80 \
    -v /home/user/webroot:/var/www \
    -e PHP_ERROR_REPORTING='E_ALL & ~E_STRICT' \
    bazen/apache-php7
```

* `-v [local path]:/var/www` maps the container's webroot to a local path
* `-p [local port]:80` maps a local port to the container's HTTP port 80
* `-e PHP_ERROR_REPORTING=[php error_reporting settings]` sets the value of `error_reporting` in the php.ini files.

### Access apache logs

Apache is configured to log both access and error log to STDOUT. So you can simply use `docker logs` to get the log output:

`docker logs -f container-id`


Installed packages
-------------------
* Ubuntu Server 16.04, based on ubuntu docker image
* apache2
* php7.2
* php7.2-cli
* libapache2-mod-php7.2
* php-apcu
* php-xdebug
* php7.2-gd
* php7.2-json
* php7.2-ldap
* php7.2-mbstring
* php7.2-mysql
* php7.2-pgsql
* php7.2-sqlite3
* php7.2-xml
* php7.2-xsl
* php7.2-zip
* php7.2-soap
* php7.2-opcache
* composer

Default Configurations
----------------------

* Apache: .htaccess-Enabled in webroot (mod_rewrite with AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL (default, overridable per env variable)


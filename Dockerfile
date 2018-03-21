FROM ubuntu:16.04
MAINTAINER Alexander Schenkel <alex@alexi.ch>

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
      mysql-client \
      wget \
      unzip \
      pdfjam \
      pdftk \
      imagemagick \
      python-pip  \
      nodejs  \
      apache2 \
      php7.0 \
      php-curl \
      php7.0-cli \
      libapache2-mod-php7.0 \
      php-apcu \
      php7.0-gd \
      php7.0-json \
      php7.0-ldap \
      php7.0-mbstring \
      php7.0-mysql \
      php7.0-pgsql \
      php7.0-sqlite3 \
      php7.0-xml \
      php7.0-xsl \
      php7.0-zip \
      php7.0-soap \
      php7.0-opcache \
      php7.0-bz2 \
      php7.0-xmlreader \
      composer \
      build-essential libssl-dev

RUN rm /bin/sh && ln -s /bin/bash /bin/sh


ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.10.0

# Install nvm with node and npm
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

RUN npm install -g bower gulp grunt-cli grunt



#COPY apache_default /etc/apache2/sites-available/000-default.conf
#COPY run /usr/local/bin/run
#RUN chmod +x /usr/local/bin/run
#RUN a2enmod rewrite

EXPOSE 8080
#CMD ["/usr/local/bin/run"]

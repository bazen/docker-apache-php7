FROM ubuntu:18.04
MAINTAINER Felix Krüger <code@f3l1x.com>

VOLUME ["/var/www"]

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && apt-get update && apt-get install -y dialog apt-utils locales
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LC_MONETARY en_US.UTF-8

RUN apt-get clean && apt-get update && apt-get install -y \
      mysql-client \
      wget \
      unzip \
      qpdf \
      imagemagick \
      python-pip  \
      nodejs  \
      apache2 \
      php7.2 \
      php-curl \
      php7.2-cli \
      libapache2-mod-php7.2 \
      php-apcu \
      php7.2-gd \
      php7.2-json \
      php7.2-ldap \
      php7.2-mbstring \
      php7.2-mysql \
      php7.2-pgsql \
      php7.2-sqlite3 \
      php7.2-xml \
      php7.2-xsl \
      php7.2-zip \
      php7.2-soap \
      php7.2-opcache \
      php7.2-bz2 \
      php7.2-xmlreader \
      php7.2-intl \
      php-imagick \
      composer

RUN printf 'en_GB.UTF-8 UTF-8\n' >> /etc/locale.gen && locale-gen en_US.UTF-8

RUN rm /bin/sh && ln -s /bin/bash /bin/sh


ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.15.1

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


# Update ImageMagick Policy
ARG imagemagic_config=/etc/ImageMagick-6/policy.xml
RUN if [[ -f $imagemagic_config ]] ; then sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' $imagemagic_config ; else echo did not see file $imagemagic_config ; fi


#
#RUN php -r "echo setlocale(LC_ALL, 0);"
#RUN php -r "setlocale(LC_MONETARY, 'en_US.UTF-8');   setlocale(LC_ALL, 'en_US.UTF8'); echo money_format('%#10n',10.99);"

#COPY apache_default /etc/apache2/sites-available/000-default.conf
#COPY run /usr/local/bin/run
#RUN chmod +x /usr/local/bin/run
#RUN a2enmod rewrite

EXPOSE 8080
#CMD ["/usr/local/bin/run"]

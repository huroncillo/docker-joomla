FROM ubuntu:xenial
MAINTAINER Aaron Romero <aaron_romero_97@hotmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install -y curl apache2 php libapache2-mod-php php-mysql php-gd php-mbstring mysql-server mysql-client wget
RUN rm -R /var/www/html/*
RUN apt-get clean -y && apt-get autoclean -y
WORKDIR /var/www/html
RUN wget https://github.com/joomla/joomla-cms/releases/download/3.6.5/Joomla_3.6.5-Stable-Full_Package.tar.gz
RUN tar xzvf Joomla_3.6.5-Stable-Full_Package.tar.gz
RUN chown -R www-data:www-data /var/www/
RUN service mysql restart && service apache2 restart
ADD ./run.sh /run.sh

EXPOSE 80

CMD ["/bin/bash", "/run.sh"]
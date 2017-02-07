#!/bin/bash
BASEDIR=/var/www/html

# inicialitzem els arxius de mysql
if [ ! -d /var/lib/mysql/mysql ]
then
        mysqld --initialize-insecure
fi

# fem que el mysql s'executi com a dimoni
/usr/bin/mysqld_safe > /dev/null 2>&1 &
# esperem que s'aixequi el dimoni
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

# creem la base de dades i l'anomenem wordpress
mysql -uroot -e "CREATE DATABASE wordpress;"

# fem que apache s'executi en mode dimoni
/usr/sbin/apachectl -D FOREGROUND
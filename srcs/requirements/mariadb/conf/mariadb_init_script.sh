#! /bin/sh

# Change the bind address from `127.0.0.1`` to `0.0.0.0`
sed -i -r "s/127.0.0.1/0.0.0.0/1"    /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start

sleep 10

echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE_NAME ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$MARIADB_USER_LOGIN'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '$MARIADB_USER_LOGIN'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

rm db1.sql

# bash /usr/bin/mysqld_safe

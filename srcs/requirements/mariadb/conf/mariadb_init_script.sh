#! /bin/sh

# Change the bind address from `127.0.0.1`` to `0.0.0.0`
sed -i -r "s/127.0.0.1/0.0.0.0/1"    /etc/mysql/mariadb.conf.d/50-server.cnf

#! /bin/sh

# Allows the script to exit if any of the commands fails
set -e

# Launching mysql as a background task
mysqld_safe &

echo "Creating database: ${MARIADB_DATABASE_NAME} ..."
sleep 10

echo "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';" >> db1.sql # DONE
echo "ALTER USER 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';" >> db1.sql # DONE
echo "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE_NAME}\`;" >> db1.sql # DONE
echo "CREATE USER IF NOT EXISTS '${MARIADB_USER_LOGIN}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';" >> db1.sql
echo "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE_NAME}\`.* TO \`${MARIADB_USER_LOGIN}\`@'%';" >> db1.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

# If last_exit_status == 0
if [ $? -eq 0 ]; then
    echo "Database ${MARIADB_DATABASE_NAME} created successfully."
else
    echo "Failed to create database."
fi

rm db1.sql

# bash /usr/bin/mysqld_safe

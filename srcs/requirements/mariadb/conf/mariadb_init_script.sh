#! /bin/sh

# If a command fails, script will stop immediately
set -e

# if [ ! -d "/path/to/directory" ] checks if a directory exists,
# if not, execute the code

# Checks if the path /run/mysqld exists
# be responsible for storing temporary files and important files
# for running MariaDB, such as the PID file and connection socket in the Dockerfile for MariaDB
if [ ! -d "/run/mysqld" ]; then
    echo "/run/mysqld does not exists, creating..."
    mkdir -p "/run/mysqld"
    echo "/run/mysqld CREATED"
    chown root:root /run/mysqld
fi

# Install Mariadb if, by any chance, shit's has not been installed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "MariaDB, for an obscure yet unknown reason, does not exists..."
    echo "Init MariaDB....."
    mysql_install_db
    echo "MariaDB is Created, time to DROP DATABSE; boys"
fi

# Create the database if such does not exists
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE_NAME}\`;"

# Init the main user with his password
mysql -e "CREATE USER IF NOT EXISTS \`${MARIADB_MAIN_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_MAIN_PASSWORD}';"

# Grant full access to the database to the created user.
mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE_NAME}\`.* TO \`${MARIADB_MAIN_USER}\`@'%' IDENTIFIED BY '${MARIADB_MAIN_PASSWORD}';"
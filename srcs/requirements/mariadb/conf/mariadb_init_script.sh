#! /bin/sh

# If a command fails, script will stop immediately
set -e

#
# ! NOTE
#

# if [ ! -d "/path/to/directory" ] checks if a directory does not exists

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

# `mysql -e` (-e stands for --execute) runs SQL queries without entering the DATABASE in interactive mode.

#
# ! NOTE
#
# While running a SQL query in detached mode with `mysql -e`, env variables need curly braces such as ${VARIABLE}

# Running the MariaDB service in background
mysqld_safe &

# Create the database if such does not exists
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE_NAME}\`;"

# Init the main user with his password
mysql -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER_LOGIN}\`@'localhost' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';"

# Grant full access to the database to the created user.
mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE_NAME}\`.* TO \`${MARIADB_USER_LOGIN}\`@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';"

# Modify root user
mysql -e "ALTER USER '${MARIADB_ROOT_LOGIN}'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"

# Refresh MariaDB to apply the aboves changes
mysql -e "FLUSH PRIVILEGES;"

# Restart MariaDB
# ! NOTE :   (no need to ${VARIABLE} because this is a regular shell command)
mysqladmin -u root -p $MARIADB_ROOT_PASSWORD shutdown
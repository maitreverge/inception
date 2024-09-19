#! /bin/sh

# If a command fails, script will stop immediately
set -e

# if [ ! -d "/path/to/directory" ] checks if a directory exists

# Checks if the path /run/mysqld exists
# be responsible for storing temporary files and important files
# for running MariaDB, such as the PID file and connection socket in the Dockerfile for MariaDB
if [ ! -d "/run/mysqld" ]; then
    echo "/run/mysqld does not exists, creating..."
    mkdir -p "/run/mysqld"
    echo "/run/mysqld CREATED"
fi
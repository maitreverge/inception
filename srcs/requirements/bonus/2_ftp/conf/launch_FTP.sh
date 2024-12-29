#! /bin/sh

# Quit if fails
set -e

#Enabling vsftpd
# service vsftpd start

# Add specific user
useradd -m -s /bin/bash $FTP_USER

echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# Add user to vsftpd user list
echo "$FTP_USER" >> /etc/vsftpd.userlist

# FTP User now have full permission over the Wordpress to write files
chown -R $FTP_USER:$FTP_USER /var/www/html


# /usr/sbin/vsftpd

systemctl restart vsftpd

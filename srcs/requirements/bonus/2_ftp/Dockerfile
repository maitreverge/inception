# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/23 16:58:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/29 11:52:58 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN	apt-get -y update && \
	apt install -y vsftpd systemctl 

COPY conf/launch_FTP.sh /

# RUN chmod +x launch_FTP.sh

COPY conf/vsftpd.conf /etc/vsftpd.conf

# Create the userlist
RUN touch /etc/vsftpd.userlist

ARG FTP_USER
ARG FTP_PASSWORD

RUN	useradd -m -s /bin/bash ${FTP_USER}
RUN echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
RUN echo "${FTP_USER}" >> /etc/vsftpd.userlist
RUN mkdir -p /var/www/html
RUN chown -R ${FTP_USER}:${FTP_USER} /var/www/html
RUN systemctl restart vsftpd

# RUN launch_FTP.sh

# RUN bash launch_FTP.sh

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]

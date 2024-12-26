# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/23 16:58:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/26 20:23:52 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get -y update && \
		apt install -y vsftpd systemctl man vim 

COPY conf/launch_FTP.sh /

RUN chmod +x launch_FTP.sh

COPY conf/vsftpd.conf /etc/vsftpd.conf

# Create the userlist
RUN touch /etc/vsftpd.userlist

# RUN launch_FTP.sh

ENTRYPOINT ["bash", "launch_FTP.sh"]

# ENTRYPOINT ["tail", "-f", "/dev/null"]

# CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]

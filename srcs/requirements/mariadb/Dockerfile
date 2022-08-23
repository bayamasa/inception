FROM debian:buster

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    systemd \
    vim \
    procps

COPY tool/50-client.cnf /etc/mysql/mariadb.conf.d/
COPY tool/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306
    
# ENTRYPOINT [ "mysqld" ]

FROM debian:buster

RUN apt-get update && apt-get install -y \
    mariadb-server \
    # ファイル編集用 後で削除
    vim \
    # psコマンド用 後で削除
    procps

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY conf/50-client.cnf /etc/mysql/mariadb.conf.d/
COPY tools/entry-point.sh /usr/bin/

EXPOSE 3306

ENTRYPOINT [ "sh", "/usr/bin/entry-point.sh" ] 

#!/bin/sh

mysql_error() {
    echo "ERROR: process abort"
    exit 1
}

docker_exec_client() {
    mysql -uroot -p$MARIADB_ROOT_PASSWORD -hlocalhost "$@"
}
docker_temp_server_stop() {
	kill "$MYSQL_PID"
	wait "$MYSQL_PID"
}

docker_temp_server_start() {
    echo "Waiting for server startup"

    mysqld > /dev/null 2>&1 &

    export MYSQL_PID
	MYSQL_PID=$!
    local i
    for i in {30..0}; do
        if mysqladmin ping > /dev/null 2>&1; then
            break
        fi
        sleep 1
    done
    if [ "$i" = 0 ]; then
        mysql_error "Unable to start server."
    fi
}

_main() {

    echo "Starting temporary server"
    docker_temp_server_start
    echo "Temporary server started."

    docker_exec_client << EOS
    FLUSH PRIVILEGES;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
    CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;
    CREATE USER IF NOT EXISTS $MARIADB_USER IDENTIFIED BY '$MARIADB_PASSWORD';
    GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%';
    FLUSH PRIVILEGES;
EOS

    echo "Stopping temporary server"
	docker_temp_server_stop
	echo "Temporary server stopped"
    
    echo "MariaDB init process done. Ready for start up."
    exec mysqld
}


_main

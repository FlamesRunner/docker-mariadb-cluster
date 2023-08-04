FROM mariadb:10.11

RUN apt-get update && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3306 4444 4567 4568

ENV GALERA_USER=galera \
    GALERA_PASS=galerapass \
    MAXSCALE_USER=maxscale \
    MAXSCALE_PASS=maxscalepass \
    CLUSTER_NAME=docker_cluster \
    MYSQL_ALLOW_EMPTY_PASSWORD=1

COPY scripts/ /docker-entrypoint-initdb.d/.
RUN touch /etc/mysql/conf.d/galera.cnf
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mysqld"]

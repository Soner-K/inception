FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-server

#sets the user and group ownership to mysql recursively
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./conf/my.cnf /etc/my.cnf

RUN chmod +x 

# CMD ["sh", "-c", "mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql && exec mysqld --user=mysql"]
CMD ["mariadbd", "--help", "--verbose"]

EXPOSE 3306
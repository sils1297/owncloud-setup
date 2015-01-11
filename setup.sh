#!/bin/bash

MYSQL_ROOT_PASSWORD="secret one"

docker pull sils1297/centos-owncloud
docker pull sils1297/mysql

echo "Starting mysql container..."
docker run --name="owncloud-mysql" --restart=always \
-e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" -d sils1297/mysql

echo "Starting owncloud container..."
docker run --name="owncloud" --restart=always --link owncloud-mysql:mysql -d \
-p 40080:80 -p 48080:8080 sils1297/centos-owncloud

echo "Starting owncloud mysql data container..."
docker run --name="owncloud-mysql-data" --volumes-from owncloud-mysql \
sils1297/centos /bin/echo mysql owncloud data container

echo "Starting owncloud data container..."
docker run --name="owncloud-data" --volumes-from owncloud \
sils1297/centos /bin/echo owncloud data container

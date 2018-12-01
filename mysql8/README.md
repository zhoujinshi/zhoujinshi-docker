# zhoujinshi-docker

docker volume create --name mysql-data

docker run --name cnbbx_mysql -v mysql-data:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d zhoujinshi/mysql8
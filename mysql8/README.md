# 创建存储池

docker volume create --name mysql-data

# 执行命令

docker run --name cnbbx_mysql -v mysql-data:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8.0.16
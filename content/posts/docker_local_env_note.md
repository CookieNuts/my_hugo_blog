---
title: "Docker Local ENV Note"
date: 2020-11-09T21:11:41+08:00
categories: ['Tech']
tags: [ 'Docker', 'Mysql', 'Zookeeper', 'Redis', 'Kafka']
draft: false
---

### Create Docker Network
```
docker network create docker_network
docker network ls
docker network inspect docker_network
```

### Zookeeper
```
docker pull zookeeper
docker images
mkdir -p ~/docker-data/zookeeper/data
# -d 后台运行 -e 指定时区 -p 端口映射，本地port:容器port -v 目录挂载，localPath:containerPath
docker run --name zookeeper --restart always \
    -e TZ="Asia/Shanghai" -p 2181:2181 \
    -v ~/docker-data/zookeeper/data:/data \
    -v ~/docker-data/zookeeper/conf:/conf \
    -d zookeeper
# 连接容器到私有网络
docker network connect docker_network zookeeper
docker logs -f zookeeper
# 查看容器元数据
docker inspect zookeeper
# -i 交互式保持运行 -t 单独启动终端
docker exec -it zookeeper /bin/bash
```

### Redis
```
docker pull redis
mkdir -p ~/docker-data/redis/data
vi ~/docker-data/redis/redis.conf
# --appendonly yes 开启数据持久化
docker run -p 6379:6379 --name redis --restart always \
    -e TZ="Asia/Shanghai" \
    -v ~/docker-data/redis/redis.conf:/etc/redis/redis.conf \
    -v ~/docker-data/redis/data:/data:rw \
    -d redis redis-server /etc/redis/redis.conf --appendonly yes
 
docker network connect docker_network redis
redis-cli -h localhost -p 6379
```

### Kafka
```
docker pull wurstmeister/kafka
mkdir -p ~/docker-data/kafka/config
mkdir -p ~/docker-data/kafka/logs
# 获取zookeeper内网ip
docker network inspect docker_network
# 编辑 kafka配置文件
vi ~/docker-data/kafka/config/server.properties
# 指定配置文件和存储目录挂载，指定环境变量启动kafka，指定与zk相同网络
docker run --name kafka -p 9092:9092 \
    --restart always \
    -e TZ="Asia/Shanghai" \
    -e KAFKA_BROKER_ID=0 \
    -e KAFKA_ZOOKEEPER_CONNECT=172.18.0.2:2181 \
    -e KAFKA_ADVERTISED=PLAINTEXT://192.168.2.102:9092 \
    -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 \
    -v ~/docker-data/kafka/config:/opt/kafka/config \
    -v ~/docker-data/kafka/logs:/opt/kafka/logs \
    -d wurstmeister/kafka

docker network connect docker_network kafka
    
# 测试 terminal producter
docker exec -it kafka /bin/bash
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic topic1

# 测试 terminal consumer
docker exec -it kafka /bin/bash
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic1 --from-beginning
```

### Mysql
```
# M1添加参数 --platform=linux/x86_64
docker pull mysql:5.7.35 --platform=linux/x86_64
docker run --name=mysql -p 3306:3306 --restart always --platform linux/x86_64 \
    -e TZ="Asia/Shanghai"\
    -e MYSQL_ROOT_PASSWORD=${pwd} \
    -v ~/docker-data/mysql/conf:/etc/mysql:rw \
    -v ~/docker-data/mysql/logs:/var/log/mysql:rw \
    -v ~/docker-data/mysql/data:/var/lib/mysql:rw \
    -d mysql:5.7.35

docker network connect docker_network mysql
    
docker exec -it mysql /bin/bash
mysql -h 127.0.0.1 -P 3306 -p
# 开启root远端登陆
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${pwd}' WITH GRANT OPTION;
flush privileges;
```

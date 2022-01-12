---
title: "Mac使用Docker部署Nacos 连接Mysql容器"
date: 2021-12-07T18:19:40+08:00
categories: ['Tech']
tags: ['Nacos', 'Docker', 'Mysql']
draft: false
---

[Nacos Docker官网](https://nacos.io/en-us/docs/quick-start-docker.html)  
[Nacos Github](https://github.com/nacos-group/nacos-docker)  
#### Nacos官网关于Docker提供了三种持久化存储的例子：deber(默认)、mysql-5.7、mysql-8，如果本地docker已经有mysql容器就不需要使用nacos再创建一个mysql，以下是具体的操作和修改点：
___

1. 按照官网的步骤先把项目clone下来
```Shell
git clone https://github.com/nacos-group/nacos-docker.git
cd nacos-docker
```

2. 编辑example/standalone-mysql-5.7.yaml文件，去掉mysql相关(前提本地docker已经有mysql容器且是正常运行)
![](/posts/nacos-docker-mysql-container/11189292-41e56fe574f5ded2.png "编辑example/standalone-mysql-5.7.yaml文件")

3. 编辑standalone-mysql-5.7.yaml文件可以看到依赖 env/nacos-standlone-mysql.env 这个文件，进去看一下
![](/posts/nacos-docker-mysql-container/11189292-827ca462785deee6.png "env/nacos-standlone-mysql.env")
这里的所有参数都需要与本地容器的mysql对应，需要创建nacos依赖的db，将mysql的network与nacos容器网络相连接，创建DB和用户创建操作就省略了，主要说一下docker网络连接操作

4. 创建nacos网络和将mysql网络连接到nacos
```Shell
docker network create example_default
# 此处为mysql容器name
docker network connect example_default mysql
# 查看example_default 网络的IPAddress，将env/nacos-standlone-mysql.env的MYSQL_SERVICE_HOST修改为此处IP
docker inspect mysql
```
![](/posts/nacos-docker-mysql-container/11189292-992450bf245fb2e5.png "查看example_default 网络的IPAddress")


5. 在创建好的DB中初始化nacos所需要的表，官网已经提供了[初始化脚本](https://github.com/alibaba/nacos/blob/develop/distribution/conf/nacos-mysql.sql) ，直接在mysql容器中执行source即可
![](/posts/nacos-docker-mysql-container/11189292-b72b627265ad5120.png "请注意官网Precautions 第三条关于自定义DB的初始化脚本")

6. 完成，启动nacos
```Shell
docker-compose -f example/standalone-mysql-5.7.yaml up
```

#### 注: 
如果遇到启动报错No DataSource Set的错误，请进入到nacos-standalone-mysql容器查看/home/nacos/logs/nacos.log 查看详细报错信息，一般是数据库未初始化、用户名密码、权限等配置有误

---
title: "Use Truffle & Ganache"
date: 2022-03-24T23:28:24+08:00
categories: ['Web3']
tags: ['Web3', 'Truffle', 'Utils']
draft: false
---

## 1. Truffle Unbox Downloading Unbox failed | Hosts

刚开始使用truffle学习时就会碰到这个问题，刚开始反应肯定是梯子失败了，检查无误，且也尝试访问raw.githubusercontent.com可以正常访问，所以陷入了很久的search之路，原来运营商DNS将raw.githubusercontent.com屏蔽(映射到0.0.0.0)且npm并没有使用代理访问，需要添加Hosts映射。
```
➜ truffle unbox metacoin

Starting unbox...
=================

✔ Preparing to download box
✖ Downloading
Unbox failed!
✖ Downloading
Unbox failed!
Error: Error connecting to https://raw.githubusercontent.com/truffle-box/metacoin-box/master/truffle-box.json. Please check your internet connection and try again.

Request failed with status code 503
    at createError (/usr/local/lib/node_modules/truffle/build/webpack:/node_modules/axios/lib/core/createError.js:16:1)
    at settle (/usr/local/lib/node_modules/truffle/build/webpack:/node_modules/axios/lib/core/settle.js:17:1)
    at IncomingMessage.handleStreamEnd (/usr/local/lib/node_modules/truffle/build/webpack:/node_modules/axios/lib/adapters/http.js:269:1)
    at IncomingMessage.emit (node:events:539:35)
    at endReadableNT (node:internal/streams/readable:1345:12)
    at processTicksAndRejections (node:internal/process/task_queues:83:21)
Truffle v5.5.5 (core: 5.5.5)
Node v17.8.0
```
```
# GitHub Start
192.30.255.112 gist.github.com
192.30.255.112 github.com
192.30.255.112 www.github.com
151.101.56.133 avatars0.githubusercontent.com
151.101.56.133 avatars1.githubusercontent.com
151.101.56.133 avatars2.githubusercontent.com
151.101.56.133 avatars3.githubusercontent.com
151.101.56.133 avatars4.githubusercontent.com
151.101.56.133 avatars5.githubusercontent.com
151.101.56.133 avatars6.githubusercontent.com
151.101.56.133 avatars7.githubusercontent.com
151.101.56.133 avatars8.githubusercontent.com
151.101.56.133 camo.githubusercontent.com
151.101.56.133 cloud.githubusercontent.com
151.101.56.133 gist.githubusercontent.com
151.101.56.133 marketplace-screenshots.githubusercontent.com
151.101.56.133 raw.githubusercontent.com
151.101.56.133 repository-images.githubusercontent.com
151.101.56.133 user-images.githubusercontent.com
# GitHub End
```
Hosts详细配置参考GoogleHosts [HostFile](https://raw.githubusercontent.com/googlehosts/hosts/master/hosts-files/hosts)
**注:  执行truffle unbox <box-name>记得加sudo命令，别问为什么，不然不成功.**

## 2.Truffle常用命令
```
// 初始化新的truffle项目目录
truffle init
// 编译contract目录中的文件
truffle compile
// 部署合约到指定区块链，--reset强制重新部署，--network指定网络
truffle migrate
// truffle执行自定义脚本
truffle exec script.js
// 客户端连接到指定区块链
truffle console
  // 获取contract实例返回app变量
  - #{ContractName}.deployed().then((instance) => { contract = instance } )
  // 调用合约函数
  - contract.#{ContractFunction}
```

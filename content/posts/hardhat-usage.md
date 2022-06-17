---
title: "Use Hardhat & Alchemy"
date: 2022-04-20T11:20:10+08:00
categories: ['Web3']
tags: ['Web3', 'Hardhat', 'Utils']
draft: false
---

## Hardhat常用命令
```
// 初始化hardhat项目目录
npx hardhat
// 编译contracts/目录合约文件
npx hardhat compile
// hardhat执行指定脚本 --network指定网络
npx hardhat run script.js
// 打开hardhat客户端连接指定网络 --network指定网络
npx hardhat console
// 执行test/目录测试脚本在harhat网络测试，执行前缀加`REPORT_GAS=true`环境变量开启测试Gas报告
npx hardhat test
// 部署contracts/目录合约到指定网络
npx hardhat deploy
// 运行一个本地区块链节点 暴露JSON-RPC endpoint，--fork指定复制网络使用分叉节点
npx hardhat node
```

使用[hardhat-gas-reporter](https://www.npmjs.com/package/hardhat-gas-reporter)为测试方法提供Gas报告

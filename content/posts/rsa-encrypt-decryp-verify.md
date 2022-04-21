---
title: "RSA Encrypt Decryp Verify"
date: 2022-02-21T00:01:54+08:00
categories: ['Web3']
tags: ['Web3', 'RSA']
draft: false
---

## 场景:
A需要向B发送明文消息m，如何保证消息m加密传输且不被篡改，如何确认发送者是A？

```
A:
1.A对明文消息m计算摘要，得到H(m)
2.A使用自己的privateKey对摘要H(m)加密，得到签名s
3.A将明文消息m和签名s一起使用B的publicKey加密，得到密文c，将密文c发送给B

B:
1.B得到密文c后使用自己的privateKey解密，得到明文消息m和签名s
2.B使用A的publicKey对签名s解密，得到H(m)
3.B同样对明文消息m计算摘要，得到h(m)
4.比较H(m)与h(m)是否相同，完成验签

```

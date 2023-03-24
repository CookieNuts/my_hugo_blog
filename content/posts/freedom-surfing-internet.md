---
title: "低价VPS体(tang)验(keng)记录"
date: 2020-12-18T17:10:20+08:00
categories: ['Tech']
tags: ['VPS', '科学上网', '趟坑']
draft: false
---

## 出口网络排序：
202.97 < 163 < CN2-GT< CN2-GIA
___

### 10g.biz
香港节点，刚买回来ping值测试20ms一下非常惊喜，因为买之前得知是CN2线路但是没想到这么离谱。但是这家服务器测试稳定性极差20-600ms不等还有丢包情况，估计网络带宽超卖严重，但是耐不住便宜所以想来试试水。其次ticket服务态度不错，目前在退款阶段(已退款)
![](/posts/freedom-surfing-internet/11189292-68e79676c13cebb2.jpeg "mtr-test.jpeg")
![](/posts/freedom-surfing-internet/11189292-07ba6d699493b27d.png "ping-test.png")
![](/posts/freedom-surfing-internet/11189292-8c37d808903835f9.png "退款ticket.png")


### Virmach
性价比中的战斗机，走163主干网但服务商对网络做了优化，ping值180-250稳定无丢包情况，服务器管理后台很方便，退款流程很顺畅但每个账号只限于首次提交退款ticket
![](/posts/freedom-surfing-internet/11189292-0304c3dca05ce935.png "退款ticket.png")
![](/posts/freedom-surfing-internet/11189292-b92678b1971131f8.png "更换IP.png")


### BWG
手上有一个CN2-GT的\$18.8的传家宝，也是最常用的一个VPS，网络顺畅程度目前低价主机没有遇到对手，带宽不受限测试可以到500Mbps，做完网络优化后可以看4K 油管和乃飞，但是流量只有500G个人使用绰绰有余，更换IP需要付$6提交ticket
![](/posts/freedom-surfing-internet/11189292-fb5898dc5102b4db.png "mtr-test.png")
![](/posts/freedom-surfing-internet/11189292-8ea1695ca94008b1.png "4K-test.png")


### HostDare
近期刚入的一款实实在在的CN2-GIA线路，预计后期会成为主流分流之一，网络顺畅程度预测和BWG差不多，带宽受限买入的60Mbps完全够用，做完网络优化后在晚上22:30做的4K 油管测试ConnectSpeed 平均2w+，4K无压，流量1T
![](/posts/freedom-surfing-internet/11189292-fd8036199ae87292.png "ping-test.png")
![](/posts/freedom-surfing-internet/11189292-989b225fd9db5a16.jpeg "mtr-test.jpg")
![](/posts/freedom-surfing-internet/11189292-f5a9541bf8f86baf.png "4K-test.png")

### HNCloud
一直想尝试一下超低延时的节点，调研了一段时间后选择了CN2-GIA香港节点，但是香港节点的特点就是超低带宽1-10Mpbs的小水管，即使如此价格依然很高，而且每增加1Mbps带宽价格将近翻一倍。正好碰到华纳云618促销RMB328包年(他们家不支持循环renewal，续费恢复1080)，低配小机2Mbps带宽流量不限，测速高峰时段延时都在15ms以内，油管720p播放顺畅，这个价格也是惊喜，但是不支持测试购买后不支持退款，这点在vps供应商很少见，有一定风险
![](/posts/freedom-surfing-internet/hn-ping-test.png "hn-ping-test.png")
![](/posts/freedom-surfing-internet/hn-mtr-test.jpeg "hn-mtr-test.jpeg")
![](/posts/freedom-surfing-internet/hn-youtub-test.png "hn-youtub-test.png")

### AWS LightSail
亚马逊光帆亚洲包括有许多节点，并且提供新手三个月免费使用lightsail和容器服务，对于日常使用$3.5 1C0.5G1T 和$5 1C1G2T的流量完全够个人和家庭使用，亚马逊对移动支持CMI线路，联通直连走AS4837，电信网络就不推荐会走163出口。测速联通网络高峰23点均值70ms，油管4K初始化会卡顿，后续带宽才会逐渐增加(猜想aws使用带宽懒加载模式)，推荐日本节点
![](/posts/freedom-surfing-internet/aws-jp-ping-test.png "aws-jp-ping-test.png")
![](/posts/freedom-surfing-internet/aws-jp-mtr-test.png "aws-jp-mtr-test.png")
![](/posts/freedom-surfing-internet/aws-jp-youtub-test.png "aws-jp-youtub-test.png")

### JuHost
一家香港的小型云服务厂商，主打三网直连，因为服务器在香港延迟相对会低很多，目前厂商网络带宽很足几乎没有超售情况，$4.9 1C1G1T的VPS共享100Mps带宽，这个价格和测试结果感觉到捡到了宝，希望网络带宽能保持下去可以长期持有使用。测试联通网络高峰23点均值50ms，油管4K秒开ConnectSeed平均5W+，美中不足是流量双向计量，而且IP查询很多家(包含谷歌搜索页)会定位成中国深圳，对于一些网站限制IP会比较麻烦。提供更换IP服务，单个ticket收费$5
![](/posts/freedom-surfing-internet/jh-hk-ping-test.png "jh-hk-ping-test.png")
![](/posts/freedom-surfing-internet/jh-hk-mtr-test.png "jh-hk-mtr-test.png")
![](/posts/freedom-surfing-internet/jh-hk-youtub-test.png "jh-hk-youtub-test.png")

### GCP
云服务厂商的大佬，以全球网络优化为特点，其中流量费用也是真的贵，对于中国地区出口流量单独计费。新人注册送$300三个月内试用任何服务，其中如果只用于自由上网，可以使用$5.4 N1 f1-mirco VCPU 0.6G 带宽不受限但流量单独计价，测试两个月平均每个月50G流量，单月vps+流量总费用$20+，对于普通用户来说这个价格还是太贵了。总的来说谷歌云哪哪都好，但是就一点你的钱包是否能撑得住

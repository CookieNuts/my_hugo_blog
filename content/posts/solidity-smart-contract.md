---
title: "Solidity Smart Contract"
date: 2022-02-24T23:27:09+08:00
categories: ['Web3']
tags: ['Web3', 'Solidity', 'Smart Contract']
draft: false
---

## ABI = Application Binary Interface
如果我们使用过类似protobuf或thrift作为RPC远程调用，那么就不难理解ABI的定义，类似.proto的接口定义，然后通过protobuf客户端工具生成不同语言的接口类文件，导入到项目中那么调用者就知道有哪些方法可以使用。但是不同的是，以往web2的远程调用往往会有一个server端实现这个接口并暴露服务URL；而在Web3智能合约中所有的合约都是写在区块链中，一个合约调用另一个合约也是通过区块链的地址获取并解密区块，然后执行合约，所以ABI就必须引入到发起调用方的代码上下文中。

## modifier
函数修饰器可以理解为其他语言中的interceptor，当某个方法执行前或后，使用modifier定义的代码块拦截执行。例子中取款操作只能由owner发起，所以可以使用modifier代码块验证，并在方法头修饰
``` sol
// modifier just like a java interceptor, use "_;" to decide where it can be executed firstly or afterward
modifier onlyOwner {
    require(msg.sender == owner);
    _;
}
// modifier also has paramters like function
modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
}

// only admin/owner can withdraw
function withdraw() payable onlyOwner public {
    // who call withdraw function, that means put back all the balance to deployer
    payable(msg.sender).transfer(address(this).balance);
}
```

## public, private, external, internal
```
private: 只能由所在合约调用
internal: 只能由所在合约，以及继承当前合约的方法调用，状态变量默认可见性是internal
external: 只能由外部合约调用(不能被所在合约的方法调用)
public: 能被任何地方调用
```
## view, pure
```
view: 不会修改会保存任何states variables, 用于读取BlockChain数据
pure: 不会修改会保存任何states variables, 而且也不会读取任何states variables, 仅用于计算
view和pure外部合约方法调用不会产生GasFee, 但是内部方法调用会产生GasFee
最佳实践: function a() external view / function b() external pure
```

## transfer, send, call.value
```
(address payable).transfer(value)  转账异常会抛出异常终止合约，gas有最大2300限制
(address payable).send(value)  转账返回true/false，gas有最大2300限制
(address payable).call.value(value)  转账返回true/false, 无gas限制，使用不当会造成重入攻击，因无gas限制循环转账
使用transfer转账操作
```

## require, revert, assert
```
1.require/revert/assert 语句在发生异常或assert为false时都会抛出异常
2.require和revert抛出异常后会将剩余未使用Gas退款，而assert将扣除所有Gas，assert一般用于系统级别错误
3.use customer error will save gas
```

## msg.sender VS tx.origin
```
eg1: account1 -> contractA
eg2: account2 -> contractA -> contractB

1.第一步调用合约A时，两个例子的msg.sender == tx.origin = account1/account2
2.例子2中第二步合约A调用合约B时，msg.sender = contractA; tx.origin = account2

结论：tx.origin指向最终账户地址，msg.sender是调用合约的地址
最佳实践：require(tx.origin == msg.sender) 强制要求调用方为账户地址非合约，禁止使用tx.origin做合约授权
```

## storage, memory, calldata
```
状态变量(state variable)是storage，局部变量(local variable)非基础数据类型需要显示指定存储方式

storage: 状态变量，数据将永久存储在区块链中
memory: 数据存在内容中，变量的生命周期仅存在于函数运行期间，默认是局部变量是memory
calldata: 变量数据不可修改只读，多数用于保存函数参数(external的方法的参数必须使用calldata 0.6.9以下)

1.(引用数据类型)将memory数据赋值给memroy变量，实际是memroy的指针变量指向相同内存数据
2.(引用数据类型)将状态变量赋值给storage变量，实际是storage的指针变量指向相同存储数据
3.将状态变量赋值给memory变量，相当于从storage拷贝到memory，有额外的SLOAD产生Gas费用，而且修改赋值回来会再产生SSTORE的高额Gas费用

所以修改状态变量的最佳实践：1.直接通过状态变量修改  2.使用storage变量指针接收，操作修改
```

## this
```
1.this是一个指向当前合约地址派生类的指针
2.solidity中前缀this调用方法，指的是外部合约调用方法

Eg:
address(this)
address(this).balance
this.yourFunction.selector  //获取方法签名
```

## gas fee optimization
```
1.设计使用最少的状态变量存储(SSTORE)
2.减少函数内部冗余重复读取状态变量的操作(SLOAD)，使用局部变量代替，再一更新到Storage
3.减少不必要的require检查，使用多重条件&&连接的require
4.单线变量交换: (a, b) = (b, a)
5.使用<>代替<=, >=操作
6.调用函数使用internal修饰会更节省Gas，因为参数会以引用传递
7.合约函数多使用external少使用public
8.使用Merkle Root存储多值用于证明value存在性
9.EVM使用32byte(256bit)storage slot，可以将小单位值打包存储，EVM也尝试会将struct中小变量打包为storage slot以节省空间
10.合约代码中禁止排序，循环遍历等操作，Off-Chain Computation ，合约只做状态存储和基础共识操作
11.启用EVM优化器优化合约部署和调用GAS
```

## call，delegatecall
```
调用流程: account(使用A表示) -> proxy contract(使用P表示) -> logical contract(使用L表示)

call:
A发起交易，调用P合约，msg.sender=A, msg.value=A.value
P函数中调用L.call()时，L获取的是自己合约的storage信息:  msg.sender=L, msg.value=A.value

delegatecall: (要求L和P需要有相同且顺序一致的状态变量)
A发起交易，调用P合约，msg.sender=A, msg.value=A.value
P函数中调用L.delegatecall()时，L被动加载P合约的storage信息:  msg.sender=A, msg.value=A.value，修改的也是P中合约的状态变量

delegatecall本质是将L合约中的方法加载到P中执行代码，修改P的状态变量
```

## function selector
```
调用合约中交易结构data字段的前面4个字节为方法签名计算得出，计算方法:
bytes4(abi.encodeWithSignature(funcSinature))
bytes4(keccak256(bytes(funcSinature)))
```

## solidity漏洞
```
1.重入攻击问题，使用check-effect-interact模式防止重入攻击，openzeeplin ReentrancyGuard
2.无符号整型溢出，使用SafeMath
3.使用withdraw-pattern代替循环转账模式，防止目标合约恶意失败导致DOS攻击, openzeeplin PullPayment
4.使用OnlyOwner加强权限控制，明确函数可见性
5.使用require/assert/revert/throw条件判断机制，代替代码返回true/false方式，防止状态漏洞(虚假充值)
```

## event log 
- EVM关于日志有5个操作码：LOG0，LOG1，LOG2，LOG3，LOG4，日志内容包含topic和data两个部分，topic只能是32bytes，用于描述事件通常用事件方法签名取hash eg: keccak256(bytes('Transfer(address,address,uint256)'))
- topic最多只能有4个(4*32bytes)，topic_0固定为事件方法签名hash值，其余4个可以由自行使用indexed定义参数 eg: event Transfer(address index from, address index to, uint256 amount)  
    - topic_0: keccak256(bytes('Transfer(address,address,uint256)'))
    - topic_1: address from, topic_2: address to
    - 对应EVM中日志事件LOG3操作码，LOG3(memoryStart, memoryLength, topic1, topic2, topic3), data数据部分从[memoryStart, memoryStart + memoryLength]读取
- 事件日志gas成本：topic * 375 + bytes(data) * 8，相对状态变量gas费用很低
- 可以使用Go-ethereum/web3.js/web3.py 进行事件监听，过滤等功能

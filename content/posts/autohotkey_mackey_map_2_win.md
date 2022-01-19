---
title: "Autohotkey Mac键位全映射Win 脚本"
date: 2021-10-11T11:15:01+08:00
categories: ['Tech']
tags: ['AutohotKey', 'Shortcuts', 'Win']
draft: false
---

**由于新公司只能提供Win环境的本本且不允许使用私人电脑，而本身已经完全适应Mac环境的快捷键和操作无奈寻得使用键位映射的方式解决，了解到业内AutohotKey是做键位映射脚本的不错实践，故通过搜索以及自身使用积累总结了以下常用键位的映射脚本供参考**
+ 对于命令行完全适应unix类似iTerm替代方案，可以了解下GitBash(Mintty) + Msys2，不过需要提醒的是很多命令工具需要自行编译使用，而且win环境下运行会出现一些不可预期的问题，建议慎用不常用自行编译的命令工具
+ Mac中Spotlight全局搜索功能在Win有个叫Listary的工具，使用以下脚本基本可以做到与Mac操作近似
+ Mac中的Dock和导航栏，在Win中也有个很相似的工具MyDock，有兴趣可以试试有惊喜

### AutohotKey Win脚本
```
; ## 长按CapsLock 切换大小写，短按切换输入法中英文
SetStoreCapslockMode, off
Capslock::
	KeyWait, CapsLock
	If (A_TimeSinceThisHotkey > 300)
		SetTimer, mainp, -1
	Else
		Send ^{Space}
Return

mainp:
	Send, {CapsLock}
Return

!^q::
   DllCall("LockWorkStation")
Return

; ## 常用快捷键mac键位 -> windows键位
$!c::
    SendInput {Ctrl Down}{c}{Ctrl Up} ; alt+c 模拟 ctrl+c 复制
Return
$!x::
    SendInput {Ctrl Down}{x}{Ctrl Up} ; alt+x 模拟 ctrl+x 剪切
Return
$!v::
    SendInput {Ctrl Down}{v}{Ctrl Up} ; alt+v 模拟 ctrl+v 保存
Return
$!a::
    SendInput {Ctrl Down}{a}{Ctrl Up} ; alt+a 模拟 ctrl+a
Return
$!s::
    SendInput {Ctrl Down}{s}{Ctrl Up} ; alt+s 模拟 ctrl+s 保存
Return
$!w::
    SendInput {Ctrl Down}{w}{Ctrl Up} ; alt+w 模拟 ctrl+w 关闭窗口
Return
$!z::
    SendInput {Ctrl Down}{z}{Ctrl Up} ; alt+z 模拟 ctrl+z
Return
$!r::
    SendInput {Ctrl Down}{r}{Ctrl Up} ; alt+r 模拟 ctrl+r 刷新
Return
$!t::
    SendInput {Ctrl Down}{t}{Ctrl Up}
Return
$!q::
    SendInput {Alt Down}{F4}{Alt Up}
Return
$!f::
    SendInput {Ctrl Down}{f}{Ctrl Up}
Return
$!/::
    SendInput {Ctrl Down}{/}{Ctrl Up}
Return
$!+Left::
    SendInput {Shift Down}{Home}{Shift Up}
Return
$!+Right::
    SendInput {Shift Down}{End}{Shift Up}
Return
$!space::
    SendInput {Ctrl Down}{Ctrl Down}{Ctrl Up}{Ctrl Up} ; 唤醒Listary搜索
Return

; ## Idea 常用快捷键 mac键位 -> windows快捷键
$!Left::
	SendInput {Ctrl Down}{Alt Down}{Left}{Alt Up}{Ctrl Up} ; 上一步
Return
$!Right::
	SendInput {Ctrl Down}{Alt Down}{Right}{Alt Up}{Ctrl Up} ; 下一步
Return
$!LButton::
	SendInput {Ctrl Down}{Click Left}{Ctrl Up} ; 点击进入
Return
$!#b::
	SendInput {Ctrl Down}{Alt Down}{b}{Alt Up}{Ctrl Up} ; 寻找实现方法进入
Return
$!#l::
	SendInput {Ctrl Down}{Alt Down}{l}{Alt Up}{Ctrl Up} ; 格式化代码
Return
$!#o::
	SendInput {Ctrl Down}{Alt Down}{o}{Alt Up}{Ctrl Up} ; 全局自动导入
Return
$!F12::
	SendInput {Ctrl Down}{F12}{Ctrl Up} ; 类方法列表
Return
```


#!/bin/bash

#1.确定系统版本代号
Codename=$(cat /etc/os-release | grep VERSION_CODENAME |awk -F'=' '{print $2}')
echo "检测到您的Ubuntu系统版本为：$Codename"

#2.选择镜像源
echo "**********************************"
echo "请选择镜像源："
echo "
    1.阿里      
    2.清华     
    3.网易
    4.中科大
    "
echo "**********************************"
read -s -n1 sourceChoice

if [ $sourceChoice -ne 1 ] && [ $sourceChoice -ne 2 ] && [ $sourceChoice -ne 3 ];then
    echo
    echo '输入有误，Good Bye.'
    exit
fi

case $sourceChoice in
	1)
		choose='aliyun'
	;;
	2)
		choose='tsinghua'
	;;
	3)
		choose='163'
	;;
	4)
		choose='ustc'
	;;
esac

case $choose in
	aliyun)
		sourceweb='http://mirrors.aliyun.com'
	;;
	tsinghua)
		sourceweb='https://mirrors.tuna.tsinghua.edu.cn'
	;;
	163)
		sourceweb='http://mirrors.163.com'
	;;
	ustc)
		sourceweb='http://mirrors.ustc.edu.cn'
	;;
esac

# 3.备份换源
echo "备份sources.list..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "设置新的镜像源..."
echo "\
deb $sourceweb/ubuntu/ $Codename main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-security main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-updates main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-proposed main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-backports main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-security main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-updates main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-proposed main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-backports main restricted universe multiverse">/etc/apt/sources.list
echo "更新源..."
sudo apt-get update

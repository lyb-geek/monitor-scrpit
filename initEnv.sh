#!/bin/sh
installFileDir=`pwd`
curDate=`date +%Y%m%d%H%M%S`

# 设置hostanme
localHostName=`hostname`
isSetLocalHostName=`grep $localHostName /etc/hosts | wc -l`
if [[ $isSetLocalHostName = 0 ]]; then
    echo "127.0.0.1   $localHostName" >> /etc/hosts
fi

# 安装必要的软件
yum -y install lrzsz
yum -y install telnet
yum -y install nc
yum -y install dos2unix
yum -y install unzip zip
yum -y install lsof
yum -y install libaio
yum -y install libaio-devel
yum install git gcc gcc-c++ make automake autoconf libtool pcre pcre-devel zlib zlib-devel openssl-devel -y

#创建组和用户
echo "创建组和用户开始"
chattr -i /etc/group;chattr -i /etc/gshadow;chattr -i /etc/passwd;chattr -i /etc/shadow
groupadd fusecdn
useradd -g fusecdn fusecdn
chattr +i /etc/group;chattr +i /etc/gshadow;chattr +i /etc/passwd;chattr +i /etc/shadow
echo "创建组和用户结束"

#配置用户的最大句柄数
echo "给用户配置最大句柄数开始"
isSetLimit=`grep fusecdn /etc/security/limits.conf | wc -l`
if [[ $isSetLimit = 0 ]]; then
    echo "* soft nproc unlimited" >> /etc/security/limits.conf
    echo "root soft nproc unlimited" >> /etc/security/limits.conf
    echo "oauser soft nofile 65536" >> /etc/security/limits.conf
    echo "oauser hard nofile 131072" >> /etc/security/limits.conf
fi
cat >/etc/security/limits.d/90-nproc.conf <<EOF
*          soft    nproc     unlimited
root       soft    nproc     unlimited
*          soft    nofile    65536
*          hard    nofile    131072
EOF
echo "给用户配置最大句柄数结束"

mkdir -p /fusecdn/other
chmod -R 777 /fusecdn/other


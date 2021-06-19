#!/bin/bash
###############################
# 支持CENTOS7|Debian|Ubutu     #
# author:siemenstutorials     #
###############################
#安装libsodium
yum -y groupinstall "Development Tools"
wget https://github.com/siemenstutorials/ssr/releases/download/v1.0.16/libsodium-1.0.16.tar.gz
tar xf libsodium-1.0.16.tar.gz && cd libsodium-1.0.16
./configure && make -j2 && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig
#安装Pip
apt install wget || yum -y install wget
apt-get install python-pip || yum -y install python-pip
apt-get install python-setuptools || yum install python-setuptools
apt install python-pip || yum install -y python-pip
easy_install pip
pip install setuptools==33.1.1
#安装后端
cd /root
apt-get install git -y || yum install git -y
git clone https://github.com/siemenstutorials/shadowsocksr.git
cd shadowsocksr
pip install -r requirements.txt
cp apiconfig.py userapiconfig.py
cp config.json user-config.json
#设置参数
WEBAPI_TOKEN=TzCloudhuahua123
WEBAPI_URL=https://www.jisutizi.xyz
echo
read -p "Please input NodeID(Default NodeID:1)：" NODE_ID
[ -z "${NODE_ID}" ] && NODE_ID=1
echo
echo "-----------------------------------------------------"
echo "NODE_ID = ${NODE_ID}"
echo "-----------------------------------------------------"
echo
sed -i "s|8|${NODE_ID}|" userapiconfig.py
sed -i "s|https://zhaoj.in|${WEBAPI_URL}|" userapiconfig.py
sed -i "s|glzjin|${WEBAPI_TOKEN}|" userapiconfig.py
#关闭防火墙
systemctl stop firewalld && systemctl disable firewalld
#启动ssr
chmod +x run.sh
./run.sh
echo "安装完成"

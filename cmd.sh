#!/bin/bash

/usr/sbin/sshd -D &

cd ~
git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
cd ~/shadowsocks
bash initcfg.sh
cd ~
mkdir kcptun
cd kcptun
#wget https://github.com/xtaci/kcptun/releases/download/v20170301/kcptun-linux-amd64-20170308.tar.gz
wget https://github.com/xtaci/kcptun/releases/download/v20170329/kcptun-linux-386-20170329.tar.gz
tar -zxvf kcptun-linux-386-20170329.tar.gz

cd ~
git clone https://github.com/snooda/net-speeder.git
cd net-speeder
sh build.sh
cp net_speeder /usr/local/bin/net_speeder
chmod +x /usr/local/bin/net_speeder

cd ~
git clone https://github.com/hzdlive/run.git
cd ~/run

chmod +x *.sh

./kcp.sh
./ssr.sh

./net.sh

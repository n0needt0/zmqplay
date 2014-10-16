#!/usr/bin/env bash

# Get root up in here
sudo su

apt-get update

#pre reqs just to make sure
sudo apt-get install libtool autoconf automake uuid-dev mercurial build-essential wget git -y

#install latest golang

echo "installing golang"

wget https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz

tar -C /usr/local -xzf go1.3.3.linux-amd64.tar.gz

rm go1.3.3.linux-amd64.tar.gz

echo 'export PATH=/vagrant/bin:/usr/local/go/bin:$PATH' >> /home/vagrant/.profile
echo 'export GOPATH=/vagrant' >> /home/vagrant/.profile

chown vagrant:vagrant /home/vagrant/.profile

wget http://download.zeromq.org/zeromq-3.2.5.tar.gz

tar -zxvf zeromq-3.2.5.tar.gz

rm zeromq-3.2.5.tar.gz

cd zeromq-3.2.5

./configure

make

sudo make install 

ldconfig

cd ..

#lets see if we can build examples
echo "building sample zeromq server"

cp /vagrant/hwserver.c ./

gcc -o hwserver /vagrant/hwserver.c -lzmq

./hwserver &

echo "building test client"

cp /vagrant/hwclient.c ./

gcc -o hwclient /vagrant/hwclient.c -lzmq

#go build gwclient.go

echo "ssh into box and run ./hwclient to test. dont forget to find and stop hwtest server when done"
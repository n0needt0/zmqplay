#!/usr/bin/env bash

# Get root up in here
sudo su

echo "Installing Base Packages"
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -qqy --force-yes build-essential bzr git mercurial vim

#pre reqs just to make sure
sudo apt-get install libtool autoconf automake uuid-dev mercurial build-essential python-software-properties wget git pkg-config -y

#install latest php
add-apt-repository ppa:ondrej/php5

apt-get update
apt-get upgrade
apt-get install php5 php5-dev -y

#install latest golang

echo "installing golang"

export GOROOT=/usr/local/go
export GOPATH=/opt/go

wget https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz

tar -C /usr/local -xzf go1.3.3.linux-amd64.tar.gz

rm go1.3.3.linux-amd64.tar.gz

echo 'export PATH=/vagrant/bin:/usr/local/go/bin:$PATH' >> /home/vagrant/.profile
echo "export GOPATH=$GOPATH" >> /home/vagrant/.profile
echo "export GOROOT=$GOROOT" >> /home/vagrant/.profile

echo "    Configuring GOPATH"

mkdir -p $GOPATH/src $GOPATH/bin $GOPATH/pkg

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

echo "building test client"

cp /vagrant/hwclient.c ./

gcc -o hwclient /vagrant/hwclient.c -lzmq

#go build gwclient.go

#install latest php bindings

echo "installing php bindings"

git clone git://github.com/mkoppanen/php-zmq.git

cd php-zmq

phpize && ./configure

make && make install

#get go bindings for 3.X

/usr/local/go/bin/go get -tags zmq_3_x github.com/alecthomas/gozmq

#get go example book

git clone https://github.com/imatix/zguide.git

mkdir -p /etc/php5/conf.d

echo "extension=zmq.so" > /etc/php5/cli/conf.d/zmq.ini 

echo "ssh into box and run ./hwclient to test. dont forget to find and stop hwtest server when done"

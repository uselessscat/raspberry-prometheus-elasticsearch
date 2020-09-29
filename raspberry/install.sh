#!/bin/bash

GO_VERSION=1.15.2

if [ $(whoami) != "root" ]
then
    echo "Must run as root"
    exit
fi

if [ -z $(which go) ]
then
    # as i understand the RPI4 (BCM2711) uses armv8 (64 bits) but raspbian uses armv6l because no 64 bits version is activated by default
    # https://www.raspberrypi.org/forums/viewtopic.php?t=272204
    curl -Lo /tmp/go${GO_VERSION}.linux-armv6l.tar.gz https://golang.org/dl/go${GO_VERSION}.linux-armv6l.tar.gz
    tar -C /usr/local -xzf /tmp/go${GO_VERSION}.linux-armv6l.tar.gz
    
    echo "export PATH=\$PATH:/usr/local/go/bin" >> $HOME/.profile
    source $HOME/.profile
fi

go get -d github.com/prometheus/node_exporter
cd ${GOPATH-$HOME/go}/src/github.com/prometheus/node_exporter
make

mkdir /usr/node_exporter
mv node_exporter /usr/node_exporter
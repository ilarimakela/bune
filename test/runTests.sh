#!/usr/bin/env bash

VIRTUALBOX=0

if  [ -n "$(whereis vagrant)" ] && \
    [ -n "$(whereis virtualbox)" ] \
then
    vagrant up

    if [ ! $? -eq 0 ]
    then
        echo "Something went wrong when starting virtualbox with Vagrant\n"
        echo "Is Vagrant installed?\n\n"
        exit 1
    fi

    vagrant ssh -c /vagrant/test/runTests.sh
    exit 0
elif [ -n "$(whereis docker)" ]
then
    sudo service docker start
    sudo docker run -t -i -v /vagrant:/data:rw centos /data/test/installation/test.sh
else
    echo "Before running tests install docker or virtualbox and vagrant."
    exit 1
fi


# ./bune.pl
# PID
# echo $!

# RUN yum -y update
# RUN yum -y install perl-Linux-Inotify2 perl-YAML

# yum -y --nogpgcheck localinstall /vagrant/package/bune*.rpm

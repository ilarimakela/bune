# -*- mode: ruby -*-
# vi: set ft=ruby :

$install = <<SCRIPT

######################
# Install epel repos #
######################
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

#################################
# Yum update and install docker #
#################################
sudo yum -y update
sudo yum -y install docker-io man

##############################
# Install java for Jenkins #
##############################
sudo yum -y install java-1.6.0-openjdk

###################
# Install Jenkins #
###################
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y install jenkins
sudo service jenkins start
sudo chkconfig jenkins on

#############################
# Open firewall for jenkins #
#############################
sudo lokkit -s http
sudo lokkit -q --port=8080:tcp

################
# Start docker #
################
sudo service docker start

SCRIPT

Vagrant.configure("2") do |config|
    config.vm.box = "CentOS-6.4-x86_64-v20131103"

    config.vm.provision "shell", inline: $install

    config.vm.network "forwarded_port", guest: 8080, host: 8888
end


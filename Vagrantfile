# -*- mode: ruby -*-
# vi: set ft=ruby :

$install = <<SCRIPT

yum update -y

yum install -y perl-Linux-Inotify2 perl-YAML perl-Text-Glob perl-AnyEvent
yum install -y python python-pip

pip install robotframework

SCRIPT

Vagrant.configure("2") do |config|
    config.vm.box = "bookmark"
    config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"

    config.vm.network :private_network, :ip => "1.2.3.4"
    config.vm.synced_folder ".", "/vagrant", :nfs => true

    config.vm.provision "shell", inline: $install
end


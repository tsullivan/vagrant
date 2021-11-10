# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Start Kibana and go to localhost:5666 in your host's browser
  config.vm.network :forwarded_port, guest: 5601, host: 5666

  config.vm.provider "virtualbox" do |vbox|
    vbox.customize ["modifyvm", :id, "--audio", "none"]
    vbox.memory = 1024
    vbox.cpus = 2
    vbox.gui = false
  end

  config.vm.provision "shell", inline: "sh /vagrant/bootstrap.sh"

  # Centos machine
  config.vm.define "kibana-reporting-centos" do |centos|
    centos.vm.box = "centos/8"
    centos.vm.box_version = "2011.0"
    centos.vm.provision "shell", inline: <<-SHELL
      dnf update -y
      dnf install libnss3.so fontconfig freetype xorg-x11-utils -y
      dnf install xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc -y
      dnf install wget jq -y
      SHELL
    centos.vm.provision "shell", inline: "sh /vagrant/bootstrap.sh"
  end

  # Ubuntu machine
  config.vm.define "kibana-reporting-ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/focal64"
    ubuntu.vm.box_version = "20211026.0.0"
    ubuntu.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y libnss3 fonts-liberation libfontconfig1
      apt-get install -y jq
      SHELL
    ubuntu.vm.provision "shell", inline: "sh /vagrant/bootstrap.sh"

    # enable auto-sizing swap service
    # ubuntu.vm.provision "shell", inline: "sudo apt-get install swapspace -y"
  end
end

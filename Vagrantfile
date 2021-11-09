# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.network :forwarded_port, guest: 5601, host: 5666 # Start Kibana and go to localhost:5666 in your host's browser

  config.vm.provider "virtualbox" do |vbox|
    vbox.customize ["modifyvm", :id, "--audio", "none"]
    vbox.memory = 1024
    vbox.cpus = 2
    vbox.gui = false
  end

  config.vm.define "kibana-reporting-centos" do |machine|
    config.vm.box = "centos/8"
    config.vm.box_version = "2011.0"

    # Set up Centos
    config.vm.provision "shell", inline: <<-SHELL
      dnf update -y
      dnf install libnss3.so xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc fontconfig freetype -y
      dnf install wget jq -y
      SHELL
    end

  config.vm.define "kibana-reporting-ubuntu" do |machine|
    config.vm.box = "ubuntu/focal64"
    config.vm.box_version = "20211026.0.0"

    # https://islascruz.org/blog/2017/08/30/quick-tip-vagrant-ram/
    # enable auto-sizing swap service
    config.vm.provision "shell", inline: "sudo apt-get install swapspace -y"

    # Set up Ubuntu
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y libnss3 fonts-liberation libfontconfig1
      apt-get install -y jq
      SHELL
    end

  # Set up
  config.vm.provision "shell", inline: "sh /vagrant/bootstrap.sh"
end

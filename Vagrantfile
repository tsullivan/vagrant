# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network :forwarded_port, guest: 5601, host: 5666 # Start Kibana and go to localhost:5666 in your host's browser
  config.vm.provider "virtualbox" do |vbox|
    vbox.memory = 1024
    vbox.cpus = 4
    vbox.gui = false
  end

  # https://islascruz.org/blog/2017/08/30/quick-tip-vagrant-ram/
  # enable auto-sizing swap service
  config.vm.provision "shell", inline: "sudo apt-get install swapspace -y"

  # Set up
  config.vm.provision "shell", inline: "sh /vagrant/share/bootstrap.sh"
end

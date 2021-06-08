Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, guest: 5601, host: 5666 # Start Kibana and go to localhost:5666 in your host's browser

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 4096
    v.cpus = 2
  end

  config.ssh.private_key_path = ["~/.ssh/vagrant_rsa"]
  config.ssh.insert_key = false

  config.vm.provision "file", source: "~/.ssh/vagrant_rsa.pub", destination: "~/.ssh"
  config.vm.provision "shell", inline: <<-SHELL
    set -e
    cat /home/vagrant/.ssh/vagrant_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.network :forwarded_port, guest: 5601, host: 5666 # Start Kibana and go to localhost:5666 in your host's browser

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 4096
    v.cpus = 4
  end

  config.vm.provision "shell", inline: <<-SHELL
    set -e
    echo "10.0.2.2  elasticsearch" >> /etc/hosts
    apt install -y libnss3 fonts-liberation libfontconfig1
  SHELL
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
  {:name => "centos-7", :version => "1811.02", :box => "centos/7"},
  {:name => "ol-6.10", :version => "0", :box => "ol/6.10"},
  {:name => "rhel-8", :version => "3.0.8", :box => "generic/rhel8"},
]


Vagrant.configure(2) do |config|
  config.vm.synced_folder "share/", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vbox|
    # see https://github.com/hashicorp/vagrant/issues/9524
    vbox.customize ["modifyvm", :id, "--audio", "none"]
    # https://www.vagrantup.com/docs/virtualbox/configuration.html
    vbox.memory = 1024
    vbox.cpus = 1
  end

  boxes.each do |box|
    config.vm.network :forwarded_port, guest: 5601, host: 5666, auto_correct: true
    config.vm.synced_folder "./share", "/vagrant", id: "vagrant-share"

    config.vm.define box[:name], autostart: false do |machine|
      machine.vm.box = box[:box]
      machine.vm.box_version = box[:version]
    end

    sh_set_javahome config

    config.vm.provision "install-os-dependencies", type: "shell" do |script|
      script.path = "./share/scripts/#{box[:name]}.sh" # install os dependencies
    end

    config.vm.provision "download-stack-artifacts", type: "shell", env: {"STACK_VERSION" => ENV["STACK_VERSION"]}, privileged: false do |script|
      script.path = "./share/scripts/get_stack.sh" # download stack builds
    end
  end
end

def sh_set_javahome(config)
  config.vm.provision "set-javahome", type: "shell", inline: <<-SHELL
    echo 'export JAVA_HOME=$(find /usr/lib/jvm/java-* -type d -name jre | head -1)' >> /etc/profile.d/java_home.sh
  SHELL
end

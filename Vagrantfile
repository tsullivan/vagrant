# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
  {:name => "centos-7", :version => "1811.02", :box => "centos/7"},
  {:name => "ol-6.10", :version => "0", :box => "ol/6.10"},
]


Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

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

    sh_set_profile config, box[:name]

    config.vm.provision "install-os-dependencies", type: "shell" do |script|
      script.path = "./share/scripts/#{box[:name]}.sh" # install os dependencies
    end

    config.vm.provision "download-stack-artifacts", type: "shell", env: {"STACK_VERSION" => ENV["STACK_VERSION"]}, privileged: false do |script|
      script.path = "./share/scripts/get_stack.sh" # download stack builds
    end
  end
end

# Sets up a consistent prompt for all users. Or tries to. The VM might
# contain overrides for root and vagrant but this attempts to work around
# them by re-source-ing the standard prompt file.
def sh_set_profile(config, name)
  config.vm.provision "set-path", type: "shell", inline: <<-SHELL
    echo 'export JAVA_HOME=$(find /usr/lib/jvm/java-* -type d -name jre | head -1)' >> /etc/profile.d/java_home.sh
  SHELL

  config.vm.provision "set-prompt", type: "shell", inline: <<-SHELL
    echo 'export PS1="#{name}:\\w$ "' > /etc/profile.d/boxname_prompt.sh
  SHELL
end

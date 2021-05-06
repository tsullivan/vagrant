cd $HOME
tar xzf /vagrant/share/kibana-8.0.0-SNAPSHOT-linux-x86_64.tar.gz 
cp -r /vagrant/share/config/cert-bundle/ kibana-8.0.0-SNAPSHOT/config/
cp /vagrant/share/config/kibana.yml ./kibana-8.0.0-SNAPSHOT/config/

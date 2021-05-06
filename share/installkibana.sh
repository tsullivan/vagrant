sudo sh -c 'echo "10.0.2.2  elasticsearch" >> /etc/hosts'
sudo apt install -y libnss3 fonts-liberation libfontconfig1
cd $HOME
tar xzf /vagrant/share/kibana-8.0.0-SNAPSHOT-linux-x86_64.tar.gz 
cp -r /vagrant/share/config/cert-bundle/ kibana-8.0.0-SNAPSHOT/config/
cp /vagrant/share/config/kibana.yml ./kibana-8.0.0-SNAPSHOT/config/

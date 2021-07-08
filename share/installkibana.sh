cd $HOME

wget https://snapshots.elastic.co/8.1.0-2fdb91c4/downloads/kibana/kibana-8.1.0-SNAPSHOT-linux-x86_64.tar.gz
sudo apt install -y libnss3 fonts-liberation libfontconfig1
alias kibana="/home/vagrant/kibana-8.1.0-SNAPSHOT-linux-x86_64/bin/kibana"

#!/bin/sh
set -e
VERSION=8.1.0 # version of snapshot builds to download

echo "10.0.2.2  elasticsearch" >> /etc/hosts
echo "127.0.0.1  vagrant" >> /etc/hosts
apt-get update
apt-get install -y libnss3 fonts-liberation libfontconfig1
apt-get install -y jq

MANIFEST=$(curl --silent -XGET https://artifacts-api.elastic.co/v1/versions/$VERSION-SNAPSHOT/builds)
BUILD_HASH=$(echo $MANIFEST | jq -r '.builds[0]')
KBN_DOWNLOAD_URL=https://snapshots.elastic.co/$BUILD_HASH/downloads/kibana/kibana-$VERSION-SNAPSHOT-linux-x86_64.tar.gz
MBT_DOWNLOAD_URL=https://snapshots.elastic.co/$BUILD_HASH/downloads/beats/metricbeat/metricbeat-$VERSION-SNAPSHOT-linux-x86_64.tar.gz

cd /vagrant/share
rm -f kibana-*.gz
rm -f metricbeat-*.gz
wget --progress=bar:force:noscroll $KBN_DOWNLOAD_URL
wget --progress=bar:force:noscroll $MBT_DOWNLOAD_URL

echo
echo \# Latest build: $BUILD_HASH
echo \# Manifest updated: $(echo $MANIFEST | jq -r '.manifests["last-update-time"]')
echo \# Latest download URL: $KBN_DOWNLOAD_URL
echo \# Installation commands:
echo
echo \# Setup Kibana
echo    cd \$HOME
echo    tar xzvf /vagrant/share/kibana-$VERSION-SNAPSHOT-linux-x86_64.tar.gz
echo    cp /vagrant/share/config/kibana.base.yml kibana-$VERSION-SNAPSHOT/config/kibana.yml
echo    cp /vagrant/share/config/node.options kibana-$VERSION-SNAPSHOT/config/node.options
echo    cp -r /vagrant/share/config/cert-bundle kibana-$VERSION-SNAPSHOT/config/
echo
echo \# Set passwords in kibana-$VERSION-SNAPSHOT/config/kibana.yml, then run:
echo    cd kibana-$VERSION-SNAPSHOT
echo    ./bin/kibana
echo
echo \# Setup Metricbeat
echo    tar xzvf /vagrant/share/metricbeat-$VERSION-SNAPSHOT-linux-x86_64.tar.gz
echo    cp /vagrant/share/config/metricbeat.yml metricbeat-$VERSION-SNAPSHOT
echo    cd metricbeat-$VERSION-SNAPSHOT
echo    ./metricbeat modules enable linux system
echo    sudo chown root metricbeat.yml 
echo    sudo chown root modules.d/system.yml 
echo    sudo ./metricbeat -e
echo


VERSION=8.1.0 # snapshot version of kibana to download

MANIFEST=$(curl --silent -XGET https://artifacts-api.elastic.co/v1/versions/$VERSION-SNAPSHOT/builds)
BUILD_HASH=$(echo $MANIFEST | jq -r '.builds[0]')
KBN_DOWNLOAD_URL=https://snapshots.elastic.co/$BUILD_HASH/downloads/kibana/kibana-$VERSION-SNAPSHOT-linux-x86_64.tar.gz
MBT_DOWNLOAD_URL=https://snapshots.elastic.co/$BUILD_HASH/downloads/beats/metricbeat/metricbeat-$VERSION-SNAPSHOT-linux-x86_64.tar.gz

echo
echo \# Latest build: $BUILD_HASH
echo \# Manifest updated: $(echo $MANIFEST | jq -r '.manifests["last-update-time"]')
echo \# Latest download URL: $KBN_DOWNLOAD_URL
echo \# Installation commands:
echo
echo    cd /vagrant/share
echo    wget $KBN_DOWNLOAD_URL
echo    wget $MBT_DOWNLOAD_URL
echo    cd $HOME
echo
echo \# Setup Kibana
echo    tar xzvf /vagrant/share/kibana-$VERSION-SNAPSHOT-linux-x86_64.tar.gz
echo    cp /vagrant/share/config/kibana.base.yml ./kibana-$VERSION-SNAPSHOT/config/kibana.yml
echo    cp /vagrant/share/config/node.options ./kibana-$VERSION-SNAPSHOT/config/node.options
echo    cp -r /vagrant/share/config/cert-bundle ./kibana-$VERSION-SNAPSHOT/config/
echo
echo \# Set passwords in kibana-$VERSION-SNAPSHOT/config/kibana.yml, then run:
echo    cd kibana-$VERSION-SNAPSHOT
echo    ./bin/kibana
echo
echo \# Setup Metricbeat
echo    tar xzvf /vagrant/share/metricbeat-$VERSION-SNAPSHOT-linux-x86_64.tar.gz

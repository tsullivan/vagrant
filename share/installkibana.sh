VERSION=8.1.0 # snapshot version of kibana to download

MANIFEST=$(curl --silent -XGET https://artifacts-api.elastic.co/v1/versions/$VERSION-SNAPSHOT/builds)
BUILD_HASH=$(echo $MANIFEST | jq -r '.builds[0]')
DOWNLOAD_URL=https://snapshots.elastic.co/$BUILD_HASH/downloads/kibana/kibana-$VERSION-SNAPSHOT-linux-x86_64.tar.gz

echo
echo \# Latest build: $BUILD_HASH
echo \# Manifest updated: $(echo $MANIFEST | jq -r '.manifests["last-update-time"]')
echo \# Latest download URL: $DOWNLOAD_URL
echo \# Installation commands:
echo
echo   cd /vagrant/share
echo   wget $DOWNLOAD_URL
echo   cd $HOME
echo   tar xzvf /vagrant/share/kibana-$VERSION-SNAPSHOT-linux-x86_64.tar.gz
echo   cd kibana-$VERSION-SNAPSHOT
echo   cp /vagrant/share/config/kibana.base.yml ./config/kibana.yml
echo   cp /vagrant/share/config/node.options ./config/node.options
echo   cp -r /vagrant/share/config/cert-bundle ./config/
echo \# Set passwords in config/kibana.yml, then run:
echo   ./bin/kibana
echo

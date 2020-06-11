#!/usr/bin/env bash

set -x
set -o pipefail

TAG=${STACK_VERSION:-'7.7.1'}

wget --no-verbose https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${TAG}-linux-x86_64.tar.gz
tar xzf elasticsearch-${TAG}-linux-x86_64.tar.gz
ln -s elasticsearch-${TAG} elasticsearch

wget --no-verbose https://artifacts.elastic.co/downloads/kibana/kibana-${TAG}-linux-x86_64.tar.gz
tar xzf kibana-${TAG}-linux-x86_64.tar.gz
ln -s kibana-${TAG}-linux-x86_64 kibana

cp /vagrant/share/config/kibana.yml kibana/config/kibana.yml
cp /vagrant/share/config/elasticsearch.yml elasticsearch/config/elasticsearch.yml
cp /vagrant/share/config/jvm.options elasticsearch/config/jvm.options

# IF PRE-6.0:
#cd $CURRENT_DIR/kibana
#./bin/kibana-plugin install x-pack
#cd $CURRENT_DIR/elasticsearch
#./bin/elasticsearch-plugin install x-pack

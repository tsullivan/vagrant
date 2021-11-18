AUTH=elastic:changeme
export TEST_KIBANA_URL=https://${AUTH}@localhost:5601
export TEST_ES_URL=https://${AUTH}@localhost:9200
CONFIG="--config x-pack/test/functional/config.js"
ARCHIVE=reporting/ecommerce

cd $HOME/elastic/kibana

NODE_TLS_REJECT_UNAUTHORIZED=0 \
  node --no-warnings scripts/es_archiver $CONFIG load x-pack/test/functional/es_archives/${ARCHIVE}

NODE_TLS_REJECT_UNAUTHORIZED=0 \
  node --no-warnings scripts/kbn_archiver.js $CONFIG load x-pack/test/functional/fixtures/kbn_archiver/${ARCHIVE}

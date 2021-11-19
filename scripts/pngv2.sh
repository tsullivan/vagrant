#!/usr/bin/bash
HOST="http://localhost:5666"
AUTH="elastic:changeme"
WIDTH=2500

IDS=(
ec6707c0-48ad-11ec-b7c6-75ff290ed937
ad926820-48b0-11ec-98d2-bd2e2e247385
be92d2e0-48b0-11ec-98d2-bd2e2e247385
e0986350-48b0-11ec-98d2-bd2e2e247385
fc017280-48b0-11ec-98d2-bd2e2e247385
89757520-48cb-11ec-aec6-93a6b16b8efb
27a7ea90-48b1-11ec-98d2-bd2e2e247385
57a1b860-48cb-11ec-aec6-93a6b16b8efb
333e61d0-48cb-11ec-aec6-93a6b16b8efb
7eb95850-48b1-11ec-98d2-bd2e2e247385
)

for ((i=0;i<${#IDS[@]};i++)); 
do 
  ID=${IDS[$i]}
  TITLE="Test_$i"
  echo $TITLE
  curl --silent \
   -XPOST "${HOST}/api/reporting/generate/pngV2?jobParams=%28browserTimezone%3AAmerica%2FPhoenix%2Clayout%3A%28dimensions%3A%28height%3A10%2Cwidth%3A${WIDTH}%29%2Cid%3Apreserve_layout%29%2ClocatorParams%3A%28id%3ADASHBOARD_APP_LOCATOR%2Cparams%3A%28dashboardId%3A%27${ID}%27%2CpreserveSavedFilters%3A%21t%2CtimeRange%3A%28from%3A%272019-06-08T06%3A39%3A46.892Z%27%2Cto%3A%272019-07-14T14%3A43%3A40.534Z%27%29%2CuseHash%3A%21f%2CviewMode%3Aview%29%2Cversion%3A%278.1.0-SNAPSHOT%27%29%2CobjectType%3Adashboard%2Ctitle%3A%27${TITLE}%27%2Cversion%3A%278.1.0-SNAPSHOT%27%29" \
   -H "kbn-xsrf: reporting" \
   -u ${AUTH}
done

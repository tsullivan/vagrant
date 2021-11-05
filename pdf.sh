#!/bin/sh
curl -v \
  -XPOST "http://localhost:5666/api/reporting/generate/printablePdfV2?jobParams=%28browserTimezone%3AAmerica%2FPhoenix%2Clayout%3A%28dimensions%3A%28height%3A8408%2Cwidth%3A2046%29%2Cid%3Apreserve_layout%29%2ClocatorParams%3A%21%28%28id%3ADASHBOARD_APP_LOCATOR%2Cparams%3A%28dashboardId%3A%2762b39ad0-3db7-11ec-9bc7-3f00818eb96f%27%2CpreserveSavedFilters%3A%21t%2CtimeRange%3A%28from%3Anow-15m%2Cto%3Anow%29%2CuseHash%3A%21f%2CviewMode%3Aview%29%2Cversion%3A%278.1.0-SNAPSHOT%27%29%29%2CobjectType%3Adashboard%2Ctitle%3A%27Panels%20Size%20Test%2040%27%2Cversion%3A%278.1.0-SNAPSHOT%27%29" \
  -H "kbn-version: ${KIBANA_VERSION}" \
  -u elastic:changeme

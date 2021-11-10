#!/bin/sh
curl -v \
  -XPOST "http://localhost:5666/api/reporting/generate/pngV2?jobParams=%28browserTimezone%3AAmerica%2FPhoenix%2Clayout%3A%28dimensions%3A%28height%3A2332%2Cwidth%3A1744%29%2Cid%3Apreserve_layout%29%2ClocatorParams%3A%28id%3ADASHBOARD_APP_LOCATOR%2Cparams%3A%28dashboardId%3A%277adfa750-4c81-11e8-b3d7-01146121b73d%27%2CpreserveSavedFilters%3A%21t%2CtimeRange%3A%28from%3Anow-15m%2Cto%3Anow%29%2CuseHash%3A%21f%2CviewMode%3Aview%29%2Cversion%3A%278.1.0-SNAPSHOT%27%29%2CobjectType%3Adashboard%2Ctitle%3A%27%5BFlights%5D%20Global%20Flight%20Dashboard%27%2Cversion%3A%278.1.0-SNAPSHOT%27%29" \
  -H "kbn-version: ${KIBANA_VERSION}" \
  -u test_user:changeme

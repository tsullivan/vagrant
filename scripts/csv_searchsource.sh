#!/usr/bin/bash
HOST="http://localhost:5666"
AUTH="elastic:changeme"


while (true);
do
  curl --silent \
   -XPOST "${HOST}/api/reporting/generate/csv_searchsource?jobParams=%28browserTimezone%3AAmerica%2FPhoenix%2Ccolumns%3A%21%28%29%2CobjectType%3Asearch%2CsearchSource%3A%28fields%3A%21%28%28field%3A%27%2A%27%2Cinclude_unmapped%3Atrue%29%29%2Cfilter%3A%21%28%28meta%3A%28index%3Aff959d40-b880-11e8-a6d9-e546fe2bba5f%2Cparams%3A%28%29%29%2Crange%3A%28order_date%3A%28format%3Astrict_date_optional_time%2Cgte%3Anow-24h%2Fh%2Clte%3Anow%29%29%29%29%2Cindex%3Aff959d40-b880-11e8-a6d9-e546fe2bba5f%2Cparent%3A%28filter%3A%21%28%29%2Cindex%3Aff959d40-b880-11e8-a6d9-e546fe2bba5f%2Cquery%3A%28language%3Akuery%2Cquery%3A%27%27%29%29%2Csort%3A%21%28%28order_date%3Adesc%29%29%2CtrackTotalHits%3A%21t%29%2Ctitle%3A%27Discover%20search%20%5B2021-11-23T17%3A09%3A43.994-07%3A00%5D%27%2Cversion%3A%277.15.1%27%29" \
   -H "kbn-xsrf: reporting" \
   -u ${AUTH}
  sleep 15
done

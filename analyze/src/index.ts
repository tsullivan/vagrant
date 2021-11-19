import { getSettings } from './get_settings';
import { getData } from './get_data';
import assert from 'assert';

const argv = require('yargs').argv;

let fileName: string;
try {
  ({ f: fileName } = argv);
  assert(typeof fileName === 'string');
} catch (err) {
  throw new Error(`File name must be given. Usage: 'node main.js -f fileName'`);
}

// eslint-disable-next-line no-console
const lag = (message: string) => console.log(message);
const INDEX_PREFIX = 'png_benchmarks-';

type DataSetName = '001';
const sets: DataSetName[] = ['001'];

const printData = async () => {
  for (const set of sets) {
    lag(`DELETE /${INDEX_PREFIX}${set}`);
  }

  const template = JSON.stringify(getSettings());
  lag(`PUT /_index_template/${INDEX_PREFIX}dev`);
  lag(`{"index_patterns": ["${INDEX_PREFIX}*"], "template": ${template}}`);

  const data = await getData(fileName);
  const datasets: Record<DataSetName, string[]> = {
    '001': data,
  };

  for (const set of sets) {
    lag(`POST /${INDEX_PREFIX}${set}/_bulk`);
    for (const doc of datasets[set]) {
      lag(doc);
    }
  }
};

printData();

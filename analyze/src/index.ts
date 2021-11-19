import assert from 'assert';
import { promises as fs } from 'fs';
import { getData } from './get_data';
import { getSettings } from './get_settings';

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
const indexPre = `png_benchmarks`;
const indexName = `${indexPre}-001`;

const printData = async () => {
  lag(`DELETE /${indexName}`);

  const template = JSON.stringify(getSettings());
  lag(`PUT /_index_template/${indexPre}-dev`);
  lag(`{"index_patterns":["${indexName}*"], "template":${template}}`);
  lag(`POST /${indexName}/_bulk`);

  const rawFile = await fs.readFile(fileName, 'utf8');
  const data = getData(rawFile.split('\n'));
  for (const doc of data) {
    lag(`{"index":{"_id":"${doc.job_id}"}}`);
    lag(JSON.stringify(doc));
  }
};

printData();

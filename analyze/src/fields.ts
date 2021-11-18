import { FieldDefinition } from './lib/field_definition';
import moment from 'moment';

interface DataSet {
  dates: FieldDefinition<moment.Moment>[];
  keywords: FieldDefinition<string>[];
  numbers: FieldDefinition<number>[];
  booleans: FieldDefinition<boolean>[];
}

const datas: DataSet = {
  dates: [
    {
      name: 'start_time',
      type: 'date',
      getValue(_jobId, logs) {
        const line = logs.find((str) => str.message.match(`Claiming`));
        if (!line) { return null; }
        const value = line['@timestamp'];
        return moment.utc(value);
      },
    },
    {
      name: 'end_time',
      type: 'date',
      getValue(_jobId, logs) {
        const line = logs.find((str) => str.message.match(`Chunk size is`));
        if (!line) { return null; }
        const value = line['@timestamp'];
        return moment.utc(value);
      },
    },
  ],
  keywords: [
    {
      name: 'job_id',
      getValue(jobId) {
        return jobId;
      },
    },
  ],
  numbers: [
    {
      name: 'page_requests',
      getValue(_jobId, logs) {
        const line = logs.find((str) =>
          str.message.match(/handled .* page requests/)
        );
        if (!line) { return null; }
        const value = line.message.replace(/^.*handled (\d+) page requests*$/, '$1');
        return parseInt(value, 10);
      },
    },
    {
      name: 'panels',
      getValue(_jobId, logs) {
        const line = logs.find((str) => str.message.match(/waiting for \d/));
        if (!line) { return null; }
        const value = line.message.replace(
          /^.*waiting for (\d+) rendered elements.*$/,
          '$1'
        );
        return parseInt(value, 10);
      },
    },
    {
      name: 'render_complete_time',
      getValue(_jobId, logs) {
        const startLine = logs.find((str) => str.message.match(`Claiming`));
        if (!startLine) { return null; }
        const startTime = moment.utc(startLine['@timestamp']);

        const renderCompleteLine = logs.find((str) =>
          str.message.match(`rendering is complete`)
        );
        if (!renderCompleteLine) { return null; }
        const renderTime = moment.utc(renderCompleteLine['@timestamp']);

        return renderTime.valueOf() - startTime.valueOf();
      },
    },
    {
      name: 'take_screenshots_time',
      getValue(_jobId, logs) {
        const startLine = logs.find((str) => str.message.match(`taking screenshots`));
        if (!startLine) { return null; }
        const startTime = moment.utc(startLine['@timestamp']);

        const byteLengthLine = logs.find((str) =>
          str.message.match(`PNG buffer byte length`)
        );
        if (!byteLengthLine) { return null; }
        const renderTime = moment.utc(byteLengthLine['@timestamp']);

        return renderTime.valueOf() - startTime.valueOf();
      },
    },
    {
      name: 'byte_length',
      getValue(_jobId, logs) {
        const line = logs.find((str) => str.message.match(`buffer byte length`));
        if (!line) { return null; }
        const value = line.message.replace(/^.*buffer byte length: (\d+).*$/, '$1');
        return parseInt(value, 10);
      },
    },
    {
      name: 'cpu',
      getValue(_jobId, logs) {
        const line = logs.find((str) => str.message.match(`Chromium consumed CPU`));
        if (!line) { return null; }
        const value = line.message.replace(
          /^.*Chromium consumed CPU (\d+)% Memory ([0-9\.]+)MB.*$/,
          '$1'
        );
        return parseInt(value, 10);
      },
    },
    {
      name: 'memory',
      getValue(_jobId, logs) {
        const line = logs.find((str) => str.message.match(`Chromium consumed CPU`));
        if (!line) { return null; }
        const string = line.message.replace(/^.*Memory ([\d\.]+)MB/, '$1');
        const valueMbs = parseFloat(string);
        return Math.round(valueMbs * 1000000); // MBs in bytes
      },
    },
  ],
  booleans: [
    {
      name: 'used_stream',
      getValue() {
        return false; // FIXME
      },
    },
    {
      name: 'completed',
      getValue(_jobId, logs) {
        const line = logs.find((str) => str.message.match(`Chunk size is`));
        return !!line;
      },
    },
  ],
};

export const fields: FieldDefinition[] = [
  ...datas.dates.map((obj) => ({ ...obj, type: 'date' as const })),
  ...datas.keywords.map((obj) => ({ ...obj, type: 'keyword' as const })),
  ...datas.numbers.map((obj) => ({ ...obj, type: 'integer' as const })),
  ...datas.booleans.map((obj) => ({ ...obj, type: 'boolean' as const })),
];

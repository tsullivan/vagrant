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
      getValue() {
        return moment.utc();
      },
    },
    {
      name: 'end_time',
      getValue() {
        return moment.utc();
      },
    },
  ].map((obj) => ({ ...obj, type: 'date' })),
  keywords: [
    {
      name: 'test_name',
      getValue() {
        return 'trantula';
      },
    },
  ].map((obj) => ({ ...obj, type: 'keyword' })),
  numbers: [
    {
      name: 'elements',
      getValue() {
        return 77;
      },
    },
    {
      name: 'render_complete_time',
      getValue() {
        return 77;
      },
    },
    {
      name: 'take_screenshots_time',
      getValue() {
        return 77;
      },
    },
    {
      name: 'byte_length',
      getValue() {
        return 77;
      },
    },
    {
      name: 'test_run',
      getValue() {
        return 9;
      },
    },
    {
      name: 'cpu',
      getValue() {
        return 0;
      },
    },
    {
      name: 'memory',
      getValue() {
        return 13;
      },
    },
  ].map((obj) => ({ ...obj, type: 'integer' })),
  booleans: [
    {
      name: 'used_stream',
      getValue() {
        return false;
      },
    },
    {
      name: 'completed',
      getValue() {
        return true;
      },
    },
  ].map((obj) => ({ ...obj, type: 'boolean' })),
};

export const fields = [
  ...datas.dates,
  ...datas.keywords,
  ...datas.numbers,
  ...datas.booleans,
];

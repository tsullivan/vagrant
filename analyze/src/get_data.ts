import { promises as fs } from 'fs';
import { fields } from './fields';

export type JobLog = any;

export async function getData(fileName: string): Promise<JobLog[]> {
  const testRuns = new Map<string, object[]>();
  const rawFile = await fs.readFile(fileName, 'utf8');
  const rawData = rawFile.split('\n');

  for (let i=0;i<rawData.length;i++) {
    const line = rawData[i].trim();
    if (!line) {
      break;
    }

    try {
      const message = JSON.parse(rawData[i]);

      // get the job id string
      // type check the testRuns map if the job id exists
      // update the array if the key exists
      // create a new array with the key if it doesnt exist
    } catch (err) {
      throw new Error(`Could not parse line ${i}!`);
    }
  }

  let iteration = 0;
  const result = fields.reduce((allFields, field) => {
    return {
      ...allFields,
      [field.name]: field.getValue([], iteration++),
    };
  }, {});
  return [result];
}

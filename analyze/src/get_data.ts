import assert from 'assert';
import { fields } from './fields';

export type JobLog = any;

function isCompleteLog(jobLog: object[] = []): jobLog is object[] {
  return jobLog.length === 10;
}

const checkJobId = (jobId: string, logLine: object) => {
  try {
    assert(jobId && jobId.length === 24);
  } catch (err) {
    throw new Error(`Could not parse line '${JSON.stringify(logLine)}' ${err}`);
  }
};

const claimingRe = /^.*Claiming PNGV2 (\S+).*$/;
const jobIdFromTagsReg = /^.*([a-z0-9]{24}).*$/;

function* myGenerator(rawData: string[]) {
  const testLogs = new Map<string, object[]>();

  for (let i = 0; i < rawData.length; i++) {
    const item = rawData[i];
    const line = item.trim();
    if (!line) {
      break;
    }

    const logLine: Record<string, any> = JSON.parse(item);
    const { message } = logLine;
    let jobId: string;

    // get the job id string
    if (message.match(/Claiming/)) {
      jobId = message.replace(claimingRe, '$1');
    } else {
      const tags = logLine.log.logger;
      jobId = tags.replace(jobIdFromTagsReg, '$1');
    }

    checkJobId(jobId, logLine);

    // type check the testRuns map if the job id exists
    // update the array if the key exists
    // create a new array with the key if it doesnt exist

    const exists = testLogs.get(jobId);
    if (exists) {
      testLogs.set(jobId, [...exists, logLine]);
    } else {
      testLogs.set(jobId, [logLine]);
    }

    // if the testRun data is complete, then yield it and remove it from the Map
    const latest = testLogs.get(jobId);
    if (isCompleteLog(latest)) {
      const doc = fields.reduce(
        (acc, field) => ({
          ...acc,
          [field.name]: field.getValue(jobId, latest),
        }),
        {}
      );

      yield doc;
      testLogs.delete(jobId);
    }
  }
}

export const getData = (fileData: string[]): Generator<object> => myGenerator(fileData);

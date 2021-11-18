import assert from 'assert';
import { fields } from './fields';

export type JobLog = any;

function isCompleteLog(jobId: string, message?: string) {
  return message?.match(`Stopping ${jobId}`);
}

const checkJobId = (jobId: string) => {
  let validJobId = false;
  try {
    assert(jobId && jobId.length === 24);
    validJobId = true;
  } catch (err) {}
  return validJobId;
};

const claimingRe = /^.*Claiming PNGV2 (\S+).*$/;
const jobIdFromMessageRe = /^.*(_doc\/|task:|job |report |Stopping )([0-9a-z]+).*$/;
const jobIdFromTagsRe = /^.*([a-z0-9]{24}).*$/;

function* myGenerator(rawData: string[]) {
  const testLogs = new Map<string, object[]>();

  for (let i = 0; i < rawData.length; i++) {
    const item = rawData[i];
    const line = item.trim();
    if (!line) {
      continue;
    }

    const logLine: Record<string, any> = JSON.parse(item);
    const { message } = logLine;
    let jobId: string;

    // get the job id string
    if (message.match(/Claiming/)) {
      jobId = message.replace(claimingRe, '$1');
    } else if (message.match(/[0-9a-z]{24}/)) {
      jobId = message.replace(jobIdFromMessageRe, '$2');
    } else {
      const tags = logLine.log.logger;
      jobId = tags.replace(jobIdFromTagsRe, '$1');
    }

    if (!checkJobId(jobId)) {
      continue;
    }

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
    const latest = testLogs.get(jobId)!;
    if (isCompleteLog(jobId, logLine.message)) {
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

export const getData = (fileData: string[]): Generator<any> => myGenerator(fileData);

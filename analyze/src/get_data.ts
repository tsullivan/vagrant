import assert from 'assert';
import { fieldDefinitions } from './fields';

export interface LogLine {
  message: string;
  log: { logger: string };
}

const checkJobId = (jobId: string) => {
  let validJobId = false;
  try {
    assert(jobId && jobId.length === 24);
    validJobId = true;
  } catch (err) {
    // ignore: non-reporting log
  }
  return validJobId;
};

function* myGenerator(rawData: string[]) {
  const testLogs = new Map<string, object[]>();

  for (let i = 0; i < rawData.length; i++) {
    const item = rawData[i];
    const line = item.trim();
    if (!line) {
      continue;
    }

    const logLine: LogLine = JSON.parse(item);
    const jobId = fieldDefinitions.getJobId(logLine);

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
    if (fieldDefinitions.isCompleteLog(jobId, logLine.message)) {
      yield fieldDefinitions.getDocument(jobId, latest);
      testLogs.delete(jobId);
    }
  }
}

export const getData = (fileData: string[]): Generator<any> => myGenerator(fileData);

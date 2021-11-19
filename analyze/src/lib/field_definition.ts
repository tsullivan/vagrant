import { JobLog } from "src/get_data";

export type MappingTypeValue = 'date' | 'keyword' | 'integer' | 'boolean';

export interface FieldDefinition<T = unknown> {
  readonly name: string;
  readonly type?: MappingTypeValue;
  getValue(jobId: string, jobLogs: JobLog[]): T;
}

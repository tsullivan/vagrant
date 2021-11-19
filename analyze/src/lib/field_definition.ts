import { JobLog } from "src/get_data";

export type MappingTypeValue = 'date' | 'keyword' | 'integer' | 'boolean';

export interface FieldDefinition<T> {
  readonly name: string;
  readonly type: MappingTypeValue;
  getValue(jobLogs: JobLog[], iteration: number): T;
}

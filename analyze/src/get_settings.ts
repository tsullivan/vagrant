import { MappingTypeValue } from './lib/field_definition';
import { fieldDefinitions as defs } from './fields';

export function getSettings() {
  const properties: Record<string, { type: MappingTypeValue }> = defs.fields.reduce(
    (acc, field) => ({
      ...acc,
      [field.name]: { type: field.type },
    }),
    {}
  );

  return {
    settings: { number_of_shards: 1, number_of_replicas: 0 },
    mappings: { properties /*, runtime */ },
  };
}

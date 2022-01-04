-- Add pipeline execution provenance metadata to wallabydb

\connect wallabydb

CREATE TABLE wallaby.run_metadata (
    "id" BIGSERIAL PRIMARY KEY,
    "run_id" BIGINT NOT NULL,
    "repository" varchar NOT NULL,
    "branch" varchar NOT NULL,
    "version" varchar NOT NULL,
    "configuration" jsonb NOT NULL,
    "parameters" jsonb NOT NULL,
    "datetime" timestamp without time zone NOT NULL
);

ALTER TABLE wallaby.run_metadata ADD FOREIGN KEY ("run_id") REFERENCES wallaby.run ("id") ON DELETE CASCADE;

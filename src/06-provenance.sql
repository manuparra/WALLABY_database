\connect wallabydb

-- Add pipeline execution provenance metadata to wallabydb
CREATE TABLE wallaby.run_metadata (
    "id" BIGSERIAL PRIMARY KEY,
    "run_id" BIGINT NOT NULL,
    "repository" varchar NOT NULL,
    "branch" varchar NOT NULL,
    "version" varchar NOT NULL,
    "configuration" jsonb NOT NULL,
    "parameters" jsonb NOT NULL,
    "added_at" timestamp without time zone
);
ALTER TABLE wallaby.run_metadata ALTER COLUMN added_at SET DEFAULT now();
ALTER TABLE wallaby.run_metadata ADD FOREIGN KEY ("run_id") REFERENCES wallaby.run ("id") ON DELETE CASCADE;

-- Tag source detection for release data
CREATE TABLE wallaby.tag_source_detection (
  "id" BIGSERIAL PRIMARY KEY,
  "tag_id" bigint NOT NULL,
  "source_detection_id" bigint NOT NULL,
  "author" text NOT NULL,
  "added_at" timestamp without time zone
);
ALTER TABLE wallaby.tag_source_detection ALTER COLUMN added_at SET DEFAULT now();
ALTER TABLE wallaby.tag_source_detection ADD FOREIGN KEY ("tag_id") REFERENCES wallaby.tag ("id") ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE wallaby.tag_source_detection ADD FOREIGN KEY ("source_detection_id") REFERENCES wallaby.source_detection ("id") ON UPDATE CASCADE ON DELETE CASCADE;
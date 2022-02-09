\connect wallabydb

-- Add pipeline execution provenance metadata to wallabydb
CREATE TABLE wallaby.run_metadata (
    "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.run_metadata ADD COLUMN "run_id" BIGINT NOT NULL;
ALTER TABLE wallaby.run_metadata ADD COLUMN "repository" varchar NOT NULL;
ALTER TABLE wallaby.run_metadata ADD COLUMN "branch" varchar NOT NULL;
ALTER TABLE wallaby.run_metadata ADD COLUMN "version" varchar NOT NULL;
ALTER TABLE wallaby.run_metadata ADD COLUMN "configuration" jsonb NOT NULL;
ALTER TABLE wallaby.run_metadata ADD COLUMN "parameters" jsonb NOT NULL;
ALTER TABLE wallaby.run_metadata ADD COLUMN "added_at" timestamp without time zone;
ALTER TABLE wallaby.run_metadata ALTER COLUMN added_at SET DEFAULT now();
ALTER TABLE wallaby.run_metadata ADD FOREIGN KEY ("run_id") REFERENCES wallaby.run ("id") ON DELETE CASCADE;

-- Tag source detection for release data
CREATE TABLE wallaby.tag_source_detection (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.tag_source_detection ADD COLUMN "tag_id" bigint NOT NULL;
ALTER TABLE wallaby.tag_source_detection ADD COLUMN "source_detection_id" bigint NOT NULL;
ALTER TABLE wallaby.tag_source_detection ADD COLUMN "author" text NOT NULL;
ALTER TABLE wallaby.tag_source_detection ADD COLUMN "added_at" timestamp without time zone;
ALTER TABLE wallaby.tag_source_detection ALTER COLUMN added_at SET DEFAULT now();
ALTER TABLE wallaby.tag_source_detection ADD FOREIGN KEY ("tag_id") REFERENCES wallaby.tag ("id") ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE wallaby.tag_source_detection ADD FOREIGN KEY ("source_detection_id") REFERENCES wallaby.source_detection ("id") ON UPDATE CASCADE ON DELETE CASCADE;
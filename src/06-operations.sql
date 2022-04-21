\connect wallabydb

-- Footprint
CREATE TABLE wallaby.observation (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.observation ADD COLUMN "sbid" BIGINT NOT NULL UNIQUE;
ALTER TABLE wallaby.observation ADD COLUMN "ra" NUMERIC NOT NULL UNIQUE;
ALTER TABLE wallaby.observation ADD COLUMN "dec" NUMERIC NOT NULL UNIQUE;
ALTER TABLE wallaby.observation ADD COLUMN "image_cube_file" VARCHAR NULL UNIQUE;
ALTER TABLE wallaby.observation ADD COLUMN "weights_cube_file" VARCHAR NULL UNIQUE;
ALTER TABLE wallaby.observation ADD COLUMN "quality" VARCHAR DEFAULT NULL;
ALTER TABLE wallaby.observation ADD COLUMN "status" VARCHAR DEFAULT NULL;

-- Identifiers (defined in advance)
CREATE TABLE wallaby.tile_identifier (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.tile_identifier ADD COLUMN "ra" NUMERIC NOT NULL UNIQUE;
ALTER TABLE wallaby.tile_identifier ADD COLUMN "dec" NUMERIC NOT NULL UNIQUE;
ALTER TABLE wallaby.tile_identifier ADD COLUMN "identifier" VARCHAR NOT NULL UNIQUE;

-- Tiles (A/B mosaics of footprints)
CREATE TABLE wallaby.tile (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.tile ADD FOREIGN KEY ("identifier_id") REFERENCES wallaby.tile_identifier ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.tile ADD FOREIGN KEY ("footprint_A") REFERENCES wallaby.observation ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.tile ADD FOREIGN KEY ("footprint_B") REFERENCES wallaby.observation ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.tile ADD COLUMN "image_cube_file" VARCHAR NULL UNIQUE;
ALTER TABLE wallaby.tile ADD COLUMN "weights_cube_file" VARCHAR NULL UNIQUE;
ALTER TABLE wallaby.tile ADD COLUMN "status" VARCHAR DEFAULT NULL;

-- Postprocessing (super-mosaics of tiles)
CREATE TABLE wallaby.postprocessing (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.postprocessing ADD FOREIGN KEY ("run_id") REFERENCES wallaby.run ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.postprocessing ADD COLUMN "sofia_parameter_file" VARCHAR DEFAULT NULL;
ALTER TABLE wallaby.postprocessing ADD COLUMN "s2p_setup" VARCHAR DEFAULT NULL;
ALTER TABLE wallaby.postprocessing ADD COLUMN "status" VARCHAR DEFAULT NULL;

-- Many-to-many map for mosaics to tiles
CREATE TABLE wallaby.mosaic (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.mosaic ADD FOREIGN KEY ("tile") REFERENCES wallaby.tile ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.mosaic ADD FOREIGN KEY ("postprocessing") REFERENCES wallaby.postprocessing ("id") ON DELETE CASCADE;

-- Prerequisite triggers
CREATE TABLE wallaby.prerequisite (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.prerequisite ADD COLUMN "run_name" VARCHAR NOT NULL;
ALTER TABLE wallaby.prerequisite ADD COLUMN "sofia_parameter_file" VARCHAR DEFAULT NULL;
ALTER TABLE wallaby.prerequisite ADD COLUMN "s2p_setup" VARCHAR DEFAULT NULL;
ALTER TABLE wallaby.prerequisite ADD COLUMN "status" VARCHAR DEFAULT NULL;

-- Map identifiers to prerequisite table
CREATE TABLE wallaby.prerequisite_identifier (
  "id" BIGSERIAL PRIMARY KEY
);
ALTER TABLE wallaby.prerequisite_identifier ADD FOREIGN KEY ("prerequisite_id")  REFERENCES wallaby.prerequisite ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.prerequisite_identifier ADD FOREIGN KEY ("identifier_id") REFERENCES wallaby.identifier ("id") ON DELETE CASCADE;

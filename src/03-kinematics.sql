\connect wallabydb

CREATE TABLE wallaby.kinematic_model (
  "id" BIGSERIAL PRIMARY KEY,
  "source_name" varchar NOT NULL,
  "Vsys_kin" double precision NOT NULL,
  "e_Vsys_kin" double precision NOT NULL,
  "X_kin" double precision NOT NULL,
  "e_X_kin" double precision NOT NULL,
  "Y_kin" double precision NOT NULL,
  "e_Y_kin" double precision NOT NULL,
  "Inc_kin" double precision NOT NULL,
  "e_Inc_kin" double precision NOT NULL,
  "PA_kin" double precision NOT NULL,
  "e_PA_kin" double precision NOT NULL,
  "RA_kin" double precision NOT NULL,
  "e_RA_kin" double precision NOT NULL,
  "DEC_kin" double precision NOT NULL,
  "e_DEC_kin" double precision NOT NULL,
  "Rotation_Profile" jsonb NOT NULL,
  "SurfaceDensity_Profile" jsonb NOT NULL,
  "Version" int NOT NULL,
  "Date"  timestamp NOT NULL,
  "Source" varchar NOT NULL
);

ALTER TABLE wallaby.kinematic_model ADD FOREIGN KEY ("source_name") REFERENCES wallaby.source ("name") ON DELETE CASCADE;

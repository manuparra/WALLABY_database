\connect sofiadb

CREATE EXTENSION postgis;
CREATE EXTENSION pg_sphere;

CREATE SCHEMA "wallaby" AUTHORIZATION "admin";

CREATE TABLE wallaby.run (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "sanity_thresholds" jsonb NOT NULL,
   unique ("name", "sanity_thresholds")
);

CREATE TABLE wallaby.instance (
  "id" BIGSERIAL PRIMARY KEY,
  "run_id" BIGINT NOT NULL,
  "filename" varchar NOT NULL,
  "boundary" integer[] NOT NULL,
  "run_date" timestamp without time zone NOT NULL,
  "flag_log" bytea,
  "reliability_plot" bytea,
  "log" bytea,
  "parameters" jsonb NOT NULL,
  "version" varchar,
  "return_code" integer,
  "stdout" bytea,
  "stderr" bytea,
  unique ("run_id", "filename", "boundary")
);

CREATE TABLE wallaby.detection (
  "id" BIGSERIAL PRIMARY KEY,
  "instance_id" BIGINT NOT NULL,
  "run_id" BIGINT NOT NULL,
  "name" varchar NOT NULL,
  "access_url" varchar NOT NULL,
  "access_format" varchar DEFAULT 'application/x-votable+xml;content=datalink' NOT NULL,
  "x" double precision NOT NULL,
  "y" double precision NOT NULL ,
  "z" double precision NOT NULL,
  "x_min" numeric NOT NULL,
  "x_max" numeric NOT NULL,
  "y_min" numeric NOT NULL,
  "y_max" numeric NOT NULL,
  "z_min" numeric NOT NULL,
  "z_max" numeric NOT NULL,
  "n_pix" numeric NOT NULL,
  "f_min" double precision NOT NULL,
  "f_max" double precision NOT NULL,
  "f_sum" double precision NOT NULL,
  "rel" double precision,
  "rms" double precision NOT NULL,
  "w20" double precision NOT NULL,
  "w50" double precision NOT NULL,
  "ell_maj" double precision NOT NULL,
  "ell_min" double precision NOT NULL,
  "ell_pa" double precision NOT NULL,
  "ell3s_maj" double precision NOT NULL,
  "ell3s_min" double precision NOT NULL,
  "ell3s_pa" double precision NOT NULL,
  "kin_pa" double precision,
  "ra" double precision,
  "dec" double precision,
  "l" double precision,
  "b" double precision,
  "v_rad" double precision,
  "v_opt" double precision,
  "v_app" double precision,
  "err_x" double precision NOT NULL,
  "err_y" double precision NOT NULL,
  "err_z" double precision NOT NULL,
  "err_f_sum" double precision NOT NULL,
  "freq" double precision,
  "flag" int,
  "unresolved" boolean DEFAULT False NOT NULL,
  "wm50" numeric NULL,
  "x_peak" integer NULL,
  "y_peak" integer NULL,
  "z_peak" integer NULL,
  "ra_peak" numeric NULL,
  "dec_peak" numeric NULL,
  "freq_peak" numeric NULL,
  "l_peak" numeric NULL,
  "b_peak" numeric NULL,
  "v_rad_peak" numeric NULL,
  "v_opt_peak" numeric NULL,
  "v_app_peak" numeric NULL,
  unique ("name", "x", "y", "z", "x_min", "x_max", "y_min", "y_max", "z_min", "z_max", "n_pix", "f_min", "f_max", "f_sum", "instance_id", "run_id")
);

CREATE TABLE wallaby.product (
  "id" BIGSERIAL PRIMARY KEY,
  "detection_id" BIGINT NOT NULL,
  "cube" bytea,
  "mask" bytea,
  "mom0" bytea,
  "mom1" bytea,
  "mom2" bytea,
  "snr" bytea,
  "chan" bytea NULL,
  "spec" bytea NULL,
  unique ("detection_id")
);

CREATE TABLE wallaby.source (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar NOT NULL
);

CREATE TABLE wallaby.source_detection (
  "id" BIGSERIAL PRIMARY KEY,
  "source_id" BIGINT NOT NULL,
  "detection_id" BIGINT NOT NULL,
  unique ("source_id")
);

CREATE TABLE wallaby.comment (
  "id" BIGSERIAL PRIMARY KEY,
  "comment" text NOT NULL,
  "detection_id" bigint NOT NULL,
  "updated_at" timestamp without time zone NOT NULL
);

CREATE TABLE wallaby.tag (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "description" text,
  "added_at" timestamp without time zone NOT NULL,
  unique ("name")
);

CREATE TABLE wallaby.tag_detection (
  "id" BIGSERIAL PRIMARY KEY,
  "tag_id" bigint NOT NULL,
  "detection_id" bigint NOT NULL,
  "added_at" timestamp without time zone NOT NULL
);

ALTER TABLE wallaby.instance ADD FOREIGN KEY ("run_id") REFERENCES wallaby.run ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.detection ADD FOREIGN KEY ("instance_id") REFERENCES wallaby.instance ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.detection ADD FOREIGN KEY ("run_id") REFERENCES wallaby.run ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.product ADD FOREIGN KEY ("detection_id") REFERENCES wallaby.detection ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.source_detection ADD FOREIGN KEY ("detection_id") REFERENCES wallaby.detection ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.source_detection ADD FOREIGN KEY ("source_id") REFERENCES wallaby.source ("id") ON DELETE CASCADE;
ALTER TABLE wallaby.comment ADD FOREIGN KEY ("detection_id") REFERENCES wallaby.detection ("id") ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE wallaby.tag_detection ADD FOREIGN KEY ("tag_id") REFERENCES wallaby.tag ("id") ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE wallaby.tag_detection ADD FOREIGN KEY ("detection_id") REFERENCES wallaby.detection ("id") ON UPDATE CASCADE ON DELETE CASCADE;

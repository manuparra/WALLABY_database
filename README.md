<h1 align="center">WALLABY Database</h1>

<!-- TODO(austin): build an official image for the WALLABY database -->

# Overview

## src

The repository contains all of the `.sql` scripts (in the [`src/`](src/) folder) necessary for initialising a PostgreSQL database with the schema used for [WALLABY](https://wallaby-survey.org/) post-processing. The tables can be separated into three different groups:

* Source finding
* Kinematics
* Multi-wavelength.

Each group captures the tables required for contributions by the AusSRC, CIRADA and SpainSRC, respectively, to the production of WALLABY catalogue data. 

### Initialisation

The first script [`01-users.sql`](src/01-users.sql) is used to create the database and create the users that will be able to access the user. It will create:

* admin user (full access)
* wallaby user (read-only access)
* vo user

### Source finding

The [`02-source-finding.sql`](src/02-source-finding.sql) and [`05-privileges.sql`](src/05-privileges.sql) scripts are used to create the tables required for source finding and access control. The tables are summarised below

| Name | Description |
|---|---|
| `run` | Name of the run (source finding application applied to a specific WALLABY data cube) |
| `instance` | Instance of the run (source finding application is parallelised and will split the entire WALLABY data cube into sub-cubes). |
| `detection` | Source finding application automatically identified detection. |
| `product` | Data products associated with a given detection (e.g. moment maps) |
| `source` | WALLABY admin determined source with a formal source name. |
| `source_detection` | Many-to-one table for mapping a source to detections. |
| `comment` | Comments applied to the detections table during manual inspection. |
| `tag` | Tag name and description. |
| `tag_detection` | Mapping from tags to the detections, added during manual inspection. |

### Kinematics

The [`03-kinematics.sql`](src/03-kinematics.sql) script is used to create the tables required for source finding and access control. The tables are summarised below: 

..

### Multi-wavelength

The [`04-multi-wavelength.sql`](src/04-multi-wavelength.sql) script is used to create the tables required for source finding and access control. The tables are summarised below: 

...

## Deployment

**NOTE** You will need to update passwords in the [`create.sql`](src/create.sql) file for any sort of security. Currently there are default passwords which are not appropriate for a production environment. You need to change them for either of the following deployment approaches.

### Docker

The easiest method for deploying the WALLABY database is with the use of the Docker container. 

To build the container you can run 

```
docker build -t wallaby_db .
```

from within the repository. Then to deploy, you can use the provided docker-compose script.

```
docker-compose up
```

### Manual

You can also install the schema on an existing PostgreSQL instance. You will also need to install dependencies `postgis` and `pg_sphere`. For Ubuntu and PostgreSQL 12, this can be done with the following command:

```
sudo apt install postgresql postgresql-contrib postgis sudo apt-get install postgresql-12-pgsphere
```

Assuming you have PostgreSQL set up correctly, from there you will be able to run the [`init.sh`](init.sh)

```
./init.sh
```

You may need to create a default user and database. This [tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04) may help with this.

## orm

We also provide an object relational mapper with SQLAlchemy that will be compatible with the database. 
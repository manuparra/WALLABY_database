# WALLABY Database

Repository for the production WALLABY database schema.

## Overview

## Schema

## Installation

To install and initialise a PostgreSQL instance with the SoFiAX_services schema run the following after cloning the repository. Note that the database requires two libraries: `postgis` and `pg_sphere`.

You may need to create a default user and database. This [tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04) may help with this.

```
# install postgresql and libraries (note we are using postgresql version 12)
sudo apt install postgresql postgresql-contrib postgis sudo apt-get install postgresql-12-pgsphere

# start postgresql
sudo systemctl start postgresql

# run initialisation scripts
cd SoFiAX_services/db
./init.sh
```

**NOTE** You will need to update passwords in the [`create.sql`](src/create.sql) file for security. Currently there are default passwords.
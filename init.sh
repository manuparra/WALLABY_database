#!/bin/bash

# Create database and users from empty PostgreSQL server locally
psql -h localhost -f src/01-users.sql
psql -h localhost -f src/02-tables.sql
psql -h localhost -f src/03-kinematics.sql
psql -h localhost -f src/04-multiwavelength.sql
psql -h localhost -f src/05-privileges.sql

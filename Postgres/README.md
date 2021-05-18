# QuickGuide | Postgres

## Contents

## Install postgres

MacOS

```bash
brew install postgres
```

List brew info

```bash
brew info postgres
```

Default data directory: the default path varies with host OS distribution.

```bash
# M1 Mac
/opt/homebrew/var/postgres

# Intel Mac
/usr/local/var/postgres
```

Custom data directory: As an alternative to using the default data directory path, you can create a custom data directory to be used as database storage. Just specify that when initializing (see later) the postgres database cluster.

```bash
mkdir ~/custom-postgres-data-dir
```

## Initialize postgres database cluster (db storage area on disk)

Initialize default or custom data directory (aka database cluster or db storage area), you need to initialize it before starting the postgres server instance from it. This is only needed the first time.

```bash
# syntax:
# pg_ctl init -D <insert-data-dir-path>

# When using default data directory path on M1 Mac:
pg_ctl init -D /opt/homebrew/var/postgres

# Alternatively when using custom data directory:
pg_ctl init -D ~/custom-postgres-data-dir
```

## Start postgres server

Initiallization process will output start command as below (may vary with OS/distro, below for M1 Mac) that can be used to start the postgres server:

```bash
# default
/opt/homebrew/Cellar/postgresql/13.2_2/bin/pg_ctl -D /opt/homebrew/var/postgres -l logfile start

# custom
/opt/homebrew/Cellar/postgresql/13.2_2/bin/pg_ctl -D /Users/abhijeetchopra/custom-postgres-data-dir -l logfile start
```

Alternatively

```bash
# syntax:
# pg_ctl start -D <insert-data-directory-path>

# default cluster / data dir
pg_ctl start -D /opt/homebrew/var/postgres

# custom cluster / data dir
pg_ctl start -D ~/custom-postgres-data-dir
```

Output:

```bash
waiting for server to start....2021-05-09 21:31:13.380 EDT [21961] LOG:  starting PostgreSQL 13.2 on arm-apple-darwin20.3.0, compiled by Apple clang version 12.0.0 (clang-1200.0.32.29), 64-bit
2021-05-09 21:31:13.381 EDT [21961] LOG:  listening on IPv6 address "::1", port 5432
2021-05-09 21:31:13.381 EDT [21961] LOG:  listening on IPv4 address "127.0.0.1", port 5432
2021-05-09 21:31:13.382 EDT [21961] LOG:  listening on Unix socket "/tmp/.s.PGSQL.5432"
2021-05-09 21:31:13.388 EDT [21962] LOG:  database system was shut down at 2021-05-09 21:30:48 EDT
2021-05-09 21:31:13.391 EDT [21961] LOG:  database system is ready to accept connections
 done
server started
```

## Check status of postgres server

```bash
# syntax:
# pg_ctl status -D <insert-data-directory-path>

pg_ctl status -D ~/opt/homebrew/var/postgres
#OR
pg_ctl status -D ~/custom-postgres-data-dir
```

Output:

```bash
pg_ctl: server is running (PID: 14484)
/opt/homebrew/Cellar/postgresql/13.2_2/bin/postgres "-D" "/Users/abhijeetchopra/custom-postgres-data-dir"
```

## Stop postgres server

```bash
# syntax:
# pg_ctl stop -D <insert-data-dir-path>

# if default cluster is currently running
pg_ctl stop -D /opt/homebrew/var/postgres

# if custom cluster is currently running
pg_ctl stop -D ~/custom-postgres-data-dir
```

Output:

```bash
waiting for server to shut down.... done
server stopped
```

## Create default database

> Homebrew does not create postgres user and database; create it manually.

```bash
psql
psql: error: FATAL:  database "abhijeetchopra" does not exist
```

Create database with same name as username from commandline

```bash
# below command will create database with name as your username
createdb
```

> Now psql will work as it default to connect to db with same name as your username on localhost:

```bash
psql

# above defaults to same as:
psql -h localhost

```

## List current data directory

If postgres server is running, run below command from postgres prompt:

```sql
postgres=#

show data_directory;
```

## Connection info

```sql
postgres=#

\conninfo
```

## Connect to database on a remote postgres server

```bash
#TODO
```

## Psql CLI

Commandline

```bash
createdb sample_db
```

Psql

Run `psql` on command line to get postgres prompt:

```bash
psql
```

Prompt will change to 'postgres=#' or 'username=#' depending on OS/distro:

```bash
postgres=#
```

## Databases

```sql
postgres=#

--create database
create database demo_database;
create database demo_database_two;

--list databases
\l

--delete/drop database
drop database demo_database_two;

--connect to different
\c demo_database_two
```

## Schemas

```sql
postgres=#

--create schema
create schema demo_schema;

--list schema
\dn

--delete/drop schema
drop schema demo_schema;
```

## Tables

```sql
postgres=#

--create table

  --create table in default schema
  create table colors (ColorID int, ColorName char(20));

  --create table in custom 'favorites' schema
  create schema favorites;
  create table favorites.colors (ColorID int, ColorName char(20));

--list tables

  --list tables in default schema i.e. 'public'
  \dt

  --list tables in specific schema
  \dt [schemaname.]
  \dt favorites.

--insert table rows

  -- e.g. insert values in table 'colors' in schema 'favorites'
  insert into favorites.colors values (1, 'red'), (2, 'blue'), (3, 'green');

--query table

  --fetch all rows from table 'colors' in schema 'favorites'
  select * from favorites.colors;

--query table row
  select * from favorites.colors where ColorName = 'red';

--delele table row
  delete from favorites.colors where ColorName = 'red';

--delete/drop table
  drop table favorites.colors;
```

## Views

```sql
postgres=#

--create view
create view manufacturing.product_details as
select products.product_id,
    products.name as product_name,
    products.manufacturing_cost,
    categories.name as category_name,
    categories.market
from manufacturing.products join manufacturing.categories
    on products.category_id = categories.category_id
;

--list views
\dv
\dv [schemaname.]

\dv manufacturing.

--query view (same as tables)
select * from manufacturing.product_details;
```

## Indexes

> Naming convention: tablename_columnname_idx

```sql
CREATE INDEX products_product_id_idx
    ON manufacturing.products USING btree
    (product_id ASC NULLS LAST)
;
```

## Default values

```sql
ALTER TABLE manufacturing.products
    ALTER COLUMN category_id SET DEFAULT 4;
```

## Contraints

### Check Constraint

> Naming convention: tablename_columnname_check

```sql
ALTER TABLE manufacturing.categories
    ADD CONSTRAINT categories_market_check CHECK (market = 'domestic' OR market = 'industrial');
```

Validation of existing data turned off

```sql
ALTER TABLE human_resources.employees
    ADD CONSTRAINT employees_hire_date_check CHECK (hire_date > '2021-01-01')
    NOT VALID;
```

### Data Constraint

```sql


```

## Importing data

```sql
postgres=#

psql -c "copy sample_table from '/tmp/file.csv' delimiter ',' csv header"
```

## User accounts and roles

```sql
CREATE ROLE hr_manager WITH
    LOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    INHERIT
    NOREPLICATION
    CONNECTION LIMIT -1
    PASSWORD 'xxxxxx';
```

```sql
select current_user;

select session_user;

set role hr_manager;

reset role;

grant usage on schema human_resources to hr_manager;
grant select on all tables in schema human_resources to hr_manager;
grant all on all tables in schema human_resources to hr_manager;

revoke all on all tables in schema human_resources from hr_manager;
revoke usage on schema human_resources from hr_manager;

drop role hr_manager;
```

## Backup and restore database

Three ways:

1. SQL dump
2. File system level backup
3. On-line backup


### SQL dump

Taking dump

```sql
pg_dump dbname > outfile
```

Restoring dump

```sql
psql dbname < infile
```

>NOTE: The database dbname will not be created by this command, you must create it yourself from template0 before executing psql

To create a database by copying template0, use:

From SQL environment:

```sql
CREATE DATABASE dbname TEMPLATE template0;
```

From commandline shell:

```bash
createdb -T template0 dbname
```

## Official Docs

- <https://www.postgresql.org/docs>

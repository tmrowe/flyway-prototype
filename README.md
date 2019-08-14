# Flyway Prototype
This prototype project demonstrates performing database migrations using Flyway, and documents the features
it provides. 

## Postgres Setup

### Docker
The Postgres database can be run within a docker container.

This will create a volume under `./data` to hold the database's data. If you would like to clear your database and 
start again delete this directory.

It is important to note that the setup scripts will only run on a clean instance. Therefore, if you need to rerun them
you will first need to delete the `./data` directory and then run `docker-compose up`.

In order to use [Docker](https://www.docker.com/get-started) you must have it installed on your host machine.

#### Commands
- To start the container detached: `docker-compose up -d`
- To stop the container: `docker-compose down`
- Show logs: `docker logs -f postgres`
- Run PSQL: `docker exec -it postgres psql --username flyway_migration --dbname flyway`

CTRL+D to exit.

Further commands can be found on the [Docker Cheat Sheet](https://www.saltycrane.com/blog/2017/08/docker-cheat-sheet/).

### Manual Setup
Setup instructions for a standalone postgres instance without using Docker.

* Localhost instance of Postgres running on port 5432. 
* Create a database named `flyway`.
* Create a user with username `flyway_migration` and password `123456`.
* Make the `flyway_migration` user the owner of the `flyway` database.
* Install the `pgcrypto` extension in the `flyway` database using `CREATE EXTENSION IF NOT EXISTS "pgcrypto";` This 
allows us to use the `gen_random_uuid()` function to generate UUIDs.

## Database
Tools for working with the database. The tools in this section allow you to connect to the database, 
view it's roles and tables, and write SQL queries. This is a short list of tools there are many others 
available.

### PSQL
The [Postgres Command Line Tools](https://www.postgresql.org/docs/9.3/app-psql.html) can be used by 
connecting to the container with `docker exec -it postgres psql --username flyway_migration --dbname flyway`

### IntelliJ Database Window
The [IntelliJ Database Window](https://www.jetbrains.com/help/idea/database-tool-window.html) can be 
configured to connect to and view the database.

Open the database window.

General Tab
```
Host: localhost
Port: 5432
User: flyway_migration
Password: 123456
Database: flyway
```

Schemas Tab
```
Tick the checkbox next to flyway.
Expand the flyway accordion.
Tick the checkbox next to the public.
```

### PG Admin
You can use [PG Admin](https://www.pgadmin.org/download/) by connecting to the database running in the container
with no additional configuration. This is a desktop application for interacting with Postgres databases.

## Migrations
Flyway supports three different types of migration; versioned, repeatable, and undo.

### Versioned Migrations
Versioned migrations are scripts run in sequence that build up our database. 

The sequence they run in is determined by the version number defined in their filename. They are only run 
once and should not be modified after they have been run. Instead the required further changes should be made in 
another versioned migration.

Flyway documentation for [versioned migrations](https://flywaydb.org/documentation/migrations#versioned-migrations).

### Undo Migrations
This is a paid feature and requires either a commercial or enterprise license to use.

Flyway supports rollbacks via undo migrations. An undo migration is responsible for reversing the change
made by a regular versioned migration. 

Flyway documentation for [undo migrations](https://flywaydb.org/getstarted/undo).

### Repeatable Migrations
Repeatable migrations are migrations that, unlike versioned migrations can be edited in place. These
migrations are run only if they have been changed. I.e. the checksum has changed since the last migration.

This is useful for things like:
- Creating views
- Creating procedures
- Creating functions
- Creating packages
- Bulk data inserts

Flyway documentation for [repeatable migrations](https://flywaydb.org/getstarted/repeatable).

### Naming Convention
Migration files in Flyway have specific requirements around the naming of the migration files as the 
filename contains both the version number and description required by Flyway. 

The three migration types have their own rules for filenames.

Versioned migrations start with a `V` followed by the version number which can be separated with underscores
or period characters, we are using periods. Then two underscores, a description of the migration, and suffixed
with a `.sql` file extension.

```
V1.1__create_user_table.sql
```

Undo migrations follow the same format as versioned migrations with the `V` replaced with a `U`.

```
U1.1__drop_user_table.sql
```

Repeatable migrations are prefixed with a `R` character, do not have a version specified, then two underscores,
followed by a description, and an `.sql` file extension.

```
R__add_users.sql
```

The [naming convention](https://flywaydb.org/documentation/migrations#naming) required by Flyway is detailed on their 
website.

## Flyway Commands
A list of commands available through Flyway.

### Migrate
This command will run all migrations from the current version the database is at all the way up to the latest. If the 
database is already up to date this command will do nothing. 

Since Postgres supports Data Definition Language (DDL) running in transactions any failed migration will be rolled back
So our database will not be left in an inconsistent state.

[Documentation](https://flywaydb.org/documentation/command/migrate) for this command can be found on the Flyway website.

### Clean
Drops all configured schemas including Flyway’s own `schema_version` table. Putting the database back into a clean 
state. Very useful for development and test environments. 

This command should **NEVER** be run on production environments as all data will be lost.

```
mvn flyway:clean
```

[Documentation](https://flywaydb.org/documentation/command/clean) for this command can be found on the Flyway website.

### Info
Prints out status information on all Flyway migrations. Including which have been run, which will be run when the 
`migrate` command is used, any failures, and any rollbacks.

```
mvn flyway:info
```

[Documentation](https://flywaydb.org/documentation/command/info) for this command can be found on the
Flyway website.

### Validate
Validates the available migrations against the applied migrations. This will detect migrations that cannot be run.

```
mvn flyway:validate
```

[Documentation](https://flywaydb.org/documentation/command/validate) for this command can be found on the Flyway website.

### Undo
Attempts to undo the most recently executed migration, or back to a target migration. This type of automatic rollback
only works if we don't mind or will not lose data by dropping columns or tables. This generally means it is only useful
for development.

This is a paid feature and requires either a commercial or enterprise license to use.

```
mvn flyway:undo
```

[Documentation](https://flywaydb.org/documentation/command/undo) for this command can be found on the Flyway website.

### Baseline
This command can be used to create a starting point for an existing database that all future migrations can be run on 
top of. 

```
mvn flyway:baseline
```

[Documentation](https://flywaydb.org/documentation/command/baseline) for this command can be found on the Flyway website.

### Repair
Repairs Flyway's `schema_version` table after a failed migration.

```
mvn flyway:repair
```

[Documentation](https://flywaydb.org/documentation/command/repair) for this command can be found on the Flyway website.

## Execution
Flyway commands can be run via Flyway's:
- [Command Line Tool](https://flywaydb.org/documentation/commandline/)
- [Maven plugin](https://flywaydb.org/documentation/maven/)
- [Java API](https://flywaydb.org/getstarted/firststeps/api)

### Command Line
The command line tools can be used on server environments were Maven is unavailable. It provides all the same commands
as listed above. 

Example: 
```
flyway migrate
```

### Maven
Running via Maven will use the Maven plugin configured in the projects `pom.xml` file.

Example: 
```
mvn flyway:migrate
```

If you are using IntelliJ IDEA you can also run the Flyway plugin via IntelliJ's Maven window.

### API
Build and run the application as a JAR with:

Example: 
```
mvn clean package
java -jar target/flyway-1.0-SNAPSHOT.jar
```

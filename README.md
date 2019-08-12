# Flyway Prototype
This prototype project demonstrates performing a database migration using Flyway. 

## Postgres Setup

### Docker
The Postgres database can be run within a docker container.

This will create a volume under `./data` to hold the database's data. If you would like to clear your database and 
start again delete this directory.

It is important to note that the setup scripts will only run on a clean instance. Therefore, if you need to rerun them
you will first need to delete the `./data` directory and then run `docker-compose up`.

#### Commands
To start the container detached:
`docker-compose up -d`

To stop the container:
`docker-compose down`

Show logs:
`docker logs -f postgres`

Run PSQL:
`docker exec -it postgres psql --username flyway_migration --dbname flyway`

CTRL+D to exit.

Further commands can be found on the [Docker Cheat Sheet](https://www.saltycrane.com/blog/2017/08/docker-cheat-sheet/).

### Manual
Setup instructions for a standalone postgres instance without using Docker.

* Localhost instance of Postgres running on port 5432. 
* Create a database named `flyway`.
* Create a user with username `flyway_migration` and password `123456` with super user privileges. 
* The `pgcrypto` extension has been installed using `CREATE EXTENSION IF NOT EXISTS "pgcrypto";` This allows
us to use the `gen_random_uuid()` function to generate UUIDs.

## PG Admin
You can use [PG Admin](https://www.pgadmin.org/download/) by connecting to the database running in the container
with no additional configuration. 

## Execution

### Command Line
Migrations can be run from the command line using Flyways Command Line tool which can be downloaded
from their website. https://flywaydb.org/download/

`flyway migrate`

Enter the username and credentials listed under Prerequisites.

### Maven
Running via Maven will use the Maven plugin configured in the projects `pom.xml` file.

`mvn clean flyway:migrate`

If using IntelliJ IDEA you can also run the plugin via IntelliJ's Maven Plugin. By running `flyway:migrate`

### API
Build and run the application with:

`mvn clean package`
`java -jar target/flyway-1.0-SNAPSHOT.jar`

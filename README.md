# Flyway Prototype

This prototype project demonstrates performing a database migration using Flyway. 

## Execution

### Prerequisites
* Localhost instance of Postgres running on port 5432. 
* Create a database named `flyway`.
* Create a user with username `flyway_migration` and password `123456` with super user privileges. 
* The `pgcrypto` extension has been installed using `CREATE EXTENSION IF NOT EXISTS "pgcrypto";` This allows
us to use the `gen_random_uuid()` function to generate UUIDs.

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

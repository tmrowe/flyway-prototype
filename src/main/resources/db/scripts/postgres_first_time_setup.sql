-- Create a user to run the migration scripts.
CREATE USER flyway_migration WITH
    PASSWORD '123456';

-- Create the database that will hold the application's tables and make the migration user the owner.
CREATE DATABASE flyway WITH
    OWNER flyway_migration;

-- TM351 PostgreSQL Database initialisation


-- Create default user and default database
CREATE USER tm351 WITH PASSWORD 'tm351';
CREATE DATABASE tm351;
GRANT ALL PRIVILEGES ON DATABASE tm351 TO tm351;


-- Create an admin superuser just in case...
CREATE USER tm351admin WITH PASSWORD 'tm351admin' SUPERUSER;

-- Create an admin superuser just in case...
CREATE USER tm351user WITH PASSWORD 'tm351user' SUPERUSER;

-- We need to set the oustudent user to a superuser so pg_dump works
CREATE ROLE oustudent WITH SUPERUSER LOGIN;


-- Legacy support
CREATE USER test PASSWORD 'test';
CREATE DATABASE tm351test;
GRANT ALL PRIVILEGES ON DATABASE tm351test TO test;



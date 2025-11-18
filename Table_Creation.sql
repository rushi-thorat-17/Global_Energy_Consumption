create database energydb;
use energydb;

-- 1. country Table:

CREATE TABLE country_3(
country VARCHAR(255) PRIMARY KEY,
cid VARCHAR(255)
);
SELECT * FROM country_3;

-- 2. emission_3 Table:

CREATE TABLE emission_3(
country VARCHAR(255),
`energy type` VARCHAR(255),
year INT,
emission INT,
`per capita emission` DOUBLE,
FOREIGN KEY (country) REFERENCES country_3(country)
);
SELECT * FROM emission_3;

-- 3. populatiion Table:

CREATE TABLE population_3(
countries VARCHAR(255),
year INT,
value DOUBLE,
FOREIGN KEY (countries) REFERENCES country_3(country)
);
SELECT * FROM population_3;

-- 4. production Table:

CREATE TABLE production_3(
country VARCHAR(255),
energy VARCHAR(255),
year INT,
production INT,
FOREIGN KEY (country) REFERENCES country_3(country)
);
SELECT * FROM production_3;

-- 5. gdp_3 Tables:

CREATE TABLE gdp_3(
country VARCHAR(255),
year INT,
value DOUBLE,
FOREIGN KEY (country) REFERENCES country_3(country)
);
SELECT * FROM gdp_3;

-- 6. consumption Table:

CREATE TABLE consum_3(
country VARCHAR(255),
energy VARCHAR(255),
year INT,
consumption INT,
FOREIGN KEY (country) REFERENCES country_3(country)
);
SELECT * FROM consum_3;

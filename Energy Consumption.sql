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


 #############  Data Analysis Questions #####################

-- What is the total emission per country for the most recent year available?

SELECT country, SUM(emission) AS total_emission
FROM emission_3
WHERE year = (SELECT MAX(year) FROM emission_3)
GROUP BY country;



-- What are the top 5 countries by GDP in the most recent year?

SELECT country, value AS gdp
FROM gdp_3
WHERE year = (SELECT MAX(year) FROM gdp_3)
ORDER BY value DESC
LIMIT 5;

-- Compare energy production and consumption by country and year.

SELECT p.country,p.year,
SUM(p.production) AS total_production,
SUM(c.consumption) AS total_consumption
FROM production_3 p
JOIN consum_3 c
    ON p.country = c.country AND p.year = c.year
GROUP BY p.country, p.year
ORDER BY p.country, p.year;


-- Which energy types contribute most to emissions across all countries?

SELECT `energy type` AS energy_type, SUM(emission) AS total_emission
FROM emission_3
GROUP BY `energy type`
ORDER BY total_emission DESC;


########## Trend Analysis Over Time ############### 

-- How have global emissions changed year over year?

SELECT year, SUM(emission) AS total_emission
FROM emission_3
GROUP BY year;


-- What is the trend in GDP for each country over the given years?

SELECT country, year, value AS gdp
FROM gdp_3
ORDER BY country, year;


-- How has population growth affected total emissions in each country?

SELECT e.country,e.year,SUM(e.emission) AS total_emission,p.value AS population,SUM(e.emission) / p.value AS per_capita_emission
FROM emission_3 e
JOIN population_3 p
    ON e.country = p.countries AND e.year = p.year
GROUP BY e.country, e.year, p.value
ORDER BY e.country, e.year;


-- Has energy consumption increased or decreased over the years for major economies?

SELECT country, year, SUM(consumption) AS total_consumption
FROM consum_3
WHERE country IN ('USA', 'China', 'India', 'Germany', 'Japan')
GROUP BY country, year
ORDER BY country, year;


-- What is the average yearly change in emissions per capita for each country?

SELECT country,year,`per capita emission`,`per capita emission` - LAG(`per capita emission`) OVER (PARTITION BY country ORDER BY year) AS yearly_change
FROM emission_3
ORDER BY country, year;

##################### Ratio & Per Capita Analysis #######################


-- What is the emission-to-GDP ratio for each country by year?

SELECT e.country,e.year,SUM(e.emission) AS total_emission,g.value AS gdp,SUM(e.emission) / g.value AS emission_to_gdp_ratio
FROM emission_3 e
JOIN gdp_3 g
    ON e.country = g.country AND e.year = g.year
GROUP BY e.country, e.year, g.value
ORDER BY e.country, e.year;


-- What is the emission-to-GDP ratio for each country by year?

SELECT e.country,e.year,SUM(e.emission) AS total_emission,g.value AS gdp,SUM(e.emission) / g.value AS emission_to_gdp_ratio
FROM emission_3 e
JOIN gdp_3 g
    ON e.country = g.country AND e.year = g.year
GROUP BY e.country, e.year, g.value
ORDER BY e.country, e.year;

-- How does energy production per capita vary across countries?

SELECT 
    p.country,
    p.year,
    (p.production / pop.value) AS production_per_capita
FROM production_3 p
JOIN population_3 pop 
    ON p.country = pop.countries 
    AND p.year = pop.year
ORDER BY production_per_capita DESC;


-- Which countries have the highest energy consumption relative to GDP?

SELECT 
    c.country,
    c.year,
    SUM(c.consumption) / SUM(g.value) AS consumption_to_gdp_ratio
FROM consum_3 c
JOIN gdp_3 g 
    ON c.country = g.country 
    AND c.year = g.year
GROUP BY c.country, c.year
ORDER BY consumption_to_gdp_ratio DESC;


-- What is the correlation between GDP growth and energy production growth?

SELECT p.country,p.year,SUM(p.production) AS total_production,pop.value AS population,SUM(p.production) / pop.value AS production_per_capita
FROM production_3 p
JOIN population_3 pop
    ON p.country = pop.countries AND p.year = pop.year
GROUP BY p.country, p.year, pop.value
ORDER BY p.country, p.year;


########################   Global Comparisons ########################


-- What are the top 10 countries by population and how do their emissions compare?

SELECT pop.countries AS country,pop.value AS population,SUM(e.emission) AS total_emission
FROM population_3 pop
JOIN emission_3 e
    ON pop.countries = e.country AND pop.year = e.year
GROUP BY pop.countries, pop.value
ORDER BY pop.value DESC
LIMIT 10;


-- Which countries have improved (reduced) their per capita emissions the most over the last decade?

SELECT country,
    MAX(`per capita emission`) - MIN(`per capita emission`) AS change_in_per_capita_emission,
    MIN(`per capita emission`) AS recent_per_capita_emission,
    MAX(`per capita emission`) AS past_per_capita_emission
FROM emission_3
WHERE year >= (SELECT MAX(year) - 10 FROM emission_3)
GROUP BY country
ORDER BY change_in_per_capita_emission DESC;


-- What is the global share (%) of emissions by country?

SELECT country,SUM(emission) AS total_emission,
    CONCAT(ROUND((SUM(emission) / (SELECT SUM(emission) FROM emission_3)) * 100, 2), '%') AS global_share_percent
FROM emission_3
GROUP BY country
ORDER BY (SUM(emission) / (SELECT SUM(emission) FROM emission_3)) DESC;


-- What is the global average GDP, emission, and population by year?

SELECT e.year,
    AVG(g.value) AS avg_gdp,
    AVG(e.emission) AS avg_emission,
    AVG(p.value) AS avg_population
FROM emission_3 e
JOIN gdp_3 g ON e.country = g.country AND e.year = g.year
JOIN population_3 p ON e.country = p.countries AND e.year = p.year
GROUP BY e.year
ORDER BY e.year;





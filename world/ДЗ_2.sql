--СТР 48
SELECT country.`Name`,country.SurfaceArea FROM `country`
WHERE country.SurfaceArea > 1000000

SELECT city.`Name`,city.Population FROM `city`
WHERE city.Population BETWEEN 500000 AND 1000000;

SELECT `Name`, `SurfaceArea` FROM `country`
WHERE `LifeExpectancy` IS NULL;

SELECT `Name`,`GNP`,`Continent` FROM `country`
WHERE `GNP` < 10000 AND `Continent` = 'Africa';

SELECT city.`Name`FROM `city`
WHERE city.`Name` LIKE 'M%';
--СТР 49
SELECT country.`Name`, country.SurfaceArea FROM `country`
WHERE country.SurfaceArea > (SELECT AVG(country.SurfaceArea) FROM `country`);

SELECT country.`Name`, country.Population FROM `country`
ORDER BY country.Population DESC
LIMIT 5;

SELECT country.`Name`,country.GNP FROM `country`
WHERE CHAR_LENGTH(country.`Name`) > 10 AND country.GNP > 50000;

SELECT city.`Name`,city.Population FROM `city`
WHERE city.Population > (SELECT AVG(city.Population) FROM `city`)
ORDER BY city.Population DESC;
--СТР 50
SELECT country.LifeExpectancy,country.GNP FROM `country`
WHERE (country.LifeExpectancy > 70 OR country.GNP < 5000) AND country.LifeExpectancy IS NOT NULL ;

SELECT country.`Name`, country.Population, (country.Population/country.SurfaceArea) AS 'Density' FROM `country`
WHERE (country.Population/country.SurfaceArea) > 100;

SELECT country.`Name`FROM `country`
WHERE country.`Name` LIKE '%e'OR country.`Name` LIKE '%a' OR country.`Name` LIKE '%i';
--СТР 51
SELECT city.`Name`,city.Population FROM `city`
WHERE CHAR_LENGTH(city.`Name`) < 5 AND city.Population > 100000
ORDER BY city.`Name`;

SELECT country.Continent, COUNT(*) AS CountCountry FROM `country`
GROUP BY country.Continent
HAVING COUNT(*) > 10;

SELECT country.`Name`, cust.Percentage FROM `country` 
JOIN (SELECT countrylanguage.`CountryCode`, countrylanguage.Percentage 
FROM `countrylanguage`
WHERE countrylanguage.`Language` = 'English' AND countrylanguage.IsOfficial = 'T' AND countrylanguage.Percentage < 50
) AS cust ON country.`Code` = cust.CountryCode;

--СТР 52
SELECT * FROM 
(SELECT city.`Name`,city.Population, cust.Region FROM `city`
JOIN (SELECT country.`Code`,country.Region FROM country) AS cust ON city.CountryCode = cust.`Code`
ORDER BY cust.Region, city.Population DESC) custom;

SELECT
    p1.Population,
    p1.Region
FROM
    (SELECT city.`Name`,city.Population, cust.Region FROM `city`
JOIN (SELECT country.`Code`,country.Region FROM country) AS cust ON city.CountryCode = cust.`Code`
ORDER BY cust.Region, city.Population DESC) p1

JOIN (SELECT city.`Name`,city.Population, cust.Region FROM `city`
JOIN (SELECT country.`Code`,country.Region FROM country) AS cust ON city.CountryCode = cust.`Code`
ORDER BY cust.Region, city.Population DESC) p2 ON p1.Region = p2.Region
AND p2.Population >= p1.Population
GROUP BY
    p1.Population,
    p1.Region
HAVING
    COUNT(*) <= 3
ORDER BY
    Region,
    Population desc;
 

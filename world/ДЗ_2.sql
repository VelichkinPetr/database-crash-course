--СТР 48
--Вывести название страны и её площадь стран, для которых 
--площадь больше 1 000 000 км²
SELECT country.`Name`,country.SurfaceArea FROM `country`
WHERE country.SurfaceArea > 1000000

--Вывести название города и его население городов, для которых 
--население больше 500 000 и меньше 1 000 000
SELECT city.`Name`,city.Population FROM `city`
WHERE city.Population BETWEEN 500000 AND 1000000;

--Вывести название страны стран, для которых значение 
--LifeExpectancy неизвестно
SELECT `Name`, `SurfaceArea` FROM `country`
WHERE `LifeExpectancy` IS NULL;

--Вывести название страны, континент и ВНП стран, для которых 
--континент — Африка и ВНП меньше 10 000
SELECT `Name`,`GNP`,`Continent` FROM `country`
WHERE `GNP` < 10000 AND `Continent` = 'Africa';

--Вывести названия городов, начинающихся с буквы "M", 
--отсортированные в обратном алфавитном порядке
SELECT city.`Name`FROM `city`
WHERE city.`Name` LIKE 'M%';

--СТР 49
--Вывести название страны и её площадь стран, для которых 
--площадь больше средней площади всех стран
SELECT country.`Name`, country.SurfaceArea FROM `country`
WHERE country.SurfaceArea > (SELECT AVG(country.SurfaceArea) FROM `country`);

--Вывести название страны и её население топ-5 стран с 
--наибольшим населением
SELECT country.`Name`, country.Population FROM `country`
ORDER BY country.Population DESC
LIMIT 5;

--Вывести название страны и ВНП стран, для которых название 
--страны длиннее 10 символов и ВНП больше 50 000
SELECT country.`Name`,country.GNP FROM `country`
WHERE CHAR_LENGTH(country.`Name`) > 10 AND country.GNP > 50000;

--Вывести название города и его население городов, для которых 
--население больше среднего населения всех городов, 
--отсортированные по убыванию населения
SELECT city.`Name`,city.Population FROM `city`
WHERE city.Population > (SELECT AVG(city.Population) FROM `city`)
ORDER BY city.Population DESC;

--СТР 50
--Вывести название страны, её LifeExpectancy и ВНП стран, для 
--которых LifeExpectancy больше 70 или ВНП меньше 5000, и 
--исключены страны с неизвестным значением LifeExpectancy
SELECT country.LifeExpectancy,country.GNP FROM `country`
WHERE (country.LifeExpectancy > 70 OR country.GNP < 5000) AND country.LifeExpectancy IS NOT NULL ;

--Вывести название страны, население и плотность населения 
--стран, для которых плотность населения больше 100 человек на 
--км²
SELECT country.`Name`, country.Population, (country.Population/country.SurfaceArea) AS 'Density' FROM `country`
WHERE (country.Population/country.SurfaceArea) > 100;

--Вывести название страны стран, для которых название 
--заканчивается на "a", "e" или "i"
SELECT country.`Name`FROM `country`
WHERE country.`Name` LIKE '%e'OR country.`Name` LIKE '%a' OR country.`Name` LIKE '%i';

--СТР 51
--Вывести название города и его население городов, для которых 
--название короче 5 символов и население больше 100 000, 
--отсортированные по названию
SELECT city.`Name`,city.Population FROM `city`
WHERE CHAR_LENGTH(city.`Name`) < 5 AND city.Population > 100000
ORDER BY city.`Name`;

--Вывести континент и количество стран для континентов, на 
--которых больше 10 стран
SELECT country.Continent, COUNT(*) AS CountCountry FROM `country`
GROUP BY country.Continent
HAVING COUNT(*) > 10;

-- Вывести название страны и процент говорящих стран, для 
--которых официальный язык — английский и процент говорящих 
--меньше 50%
SELECT country.`Name`, cust.Percentage FROM `country` 
JOIN (SELECT countrylanguage.`CountryCode`, countrylanguage.Percentage 
FROM `countrylanguage`
WHERE countrylanguage.`Language` = 'English' AND countrylanguage.IsOfficial = 'T' AND countrylanguage.Percentage < 50
) AS cust ON country.`Code` = cust.CountryCode;

--СТР 52
-- ????????????????????????????
SELECT * FROM 
(SELECT city.`Name`,city.Population, cust.Region FROM `city`
JOIN (SELECT country.`Code`,country.Region FROM country) AS cust ON city.CountryCode = cust.`Code`
ORDER BY cust.Region, city.Population DESC) custom;

--Вывести топ-3 самых густонаселённых города для каждого региона
SELECT
    c1.Population,
    c1.Region
FROM
    	(SELECT city.`Name`,city.Population, cust.Region FROM `city`
		JOIN (SELECT country.`Code`,country.Region FROM country) AS cust ON city.CountryCode = cust.`Code`
		ORDER BY cust.Region, city.Population DESC) c1

JOIN (SELECT city.`Name`,city.Population, cust.Region FROM `city`
		JOIN (SELECT country.`Code`,country.Region FROM country) AS cust ON city.CountryCode = cust.`Code`
		ORDER BY cust.Region, city.Population DESC) c2 ON c1.Region = c2.Region
		AND c2.Population >= c1.Population
GROUP BY
    c1.Population,
    c1.Region
HAVING
    COUNT(*) <= 3
ORDER BY
    Region,
    Population DESC;
-- ?????????????????????????

--Вывести название страны и количество говорящих на втором 
--официальном языке стран, для которых количество говорящих 
--превышает число жителей

-- !!! Не понял усвие =(

--Вывести название и количество городов для континентов, где 
--количество городов с населением больше 1 млн превышает 5
SELECT 
	country.Continent, 
	SUM(cust.count)
FROM `country`

JOIN (SELECT c1.CountryCode, COUNT(*) AS count FROM `city` c1
		WHERE c1.Population > 1000000
		GROUP BY c1.CountryCode) AS cust 
		ON country.`Code` = cust.CountryCode
GROUP BY country.Continent
HAVING COUNT(*) > 5;

--Вывести название и среднее население для городов, где 
--среднее население больше 500 тысяч
SELECT 
		country.`Name`,
		cust.sred 
FROM `country`

JOIN (SELECT 
			c1.CountryCode, 
			SUM(c1.Population)/COUNT(*) AS sred 
		FROM `city` c1
		GROUP BY c1.CountryCode) AS cust 
		ON country.`Code` = cust.CountryCode
WHERE cust.sred > 500000;

--СТР 53
--Вывести название континента, среднее население стран на 
--континенте и количество стран на континенте, где среднее 
--население стран больше 10 миллионов. Отсортировать по 
--среднему населению по убыванию. Ограничить вывод до 5 
--континентов с самым высоким средним населением
SELECT 
		country.Continent,
		SUM(country.Population)/COUNT(*) AS avg_population,
		COUNT(*) AS count_country
FROM `country`

GROUP BY country.Continent
		HAVING avg_population > 10000000 
		
ORDER BY avg_population DESC 
LIMIT 5;

--СТР 54
--Вывести название города и количество стран, в которых город 
--является столицей, для городов, где население больше 1 
--миллиона. Включить только те города, которые имеют более 2 
--стран, где они являются столицей. Отсортировать по 
--количеству стран по убыванию. Ограничить вывод до 10 таких 
--городов

-- !!! НЕТ УКАЗАНИЯ КАКОЙ ГОРОД СТОЛИЦА КАКОЙ СТРАНЫ

--СТР 55
--Вывести название страны и суммарное население всех городов в 
--этой стране, где суммарное население всех городов больше 20 
--миллионов. Включить в запрос подзапрос, который будет 
--возвращать все страны с населением больше 50 миллионов. 
--Отсортировать по суммарному населению по убыванию и 
--ограничить вывод до 5 стран

SELECT 
		country.`Name`,
		cust.sum_population_city 
FROM `country`

JOIN (SELECT 
			c1.CountryCode, 
			SUM(c1.Population) AS sum_population_city 
		FROM `city` c1
		GROUP BY c1.CountryCode) AS cust 
		ON country.`Code` = cust.CountryCode
WHERE cust.sum_population_city > 20000000 AND country.Population > 50000000
ORDER BY cust.sum_population_city DESC 
LIMIT 5;	


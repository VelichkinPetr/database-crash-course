-- Посчитайте количество эпизодов, выпущенных с 2002 по 2007 год
SELECT COUNT() from `episodes`
WHERE `air_date` BETWEEN '2002-01-01' AND '2008-01-01';


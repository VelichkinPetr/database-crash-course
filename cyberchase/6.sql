-- Найти названия всех эпизодов из 6 сезона (2008) которые были выпущены раньше, в 2007
SELECT `title` FROM `episodes`
WHERE `season` = 6 AND `air_date` < '2008-01-01';


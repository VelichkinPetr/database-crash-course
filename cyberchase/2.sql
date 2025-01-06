-- Вывести номер сезона и заголовок первых эпизодов каждого сезона
SELECT `season`,`title` FROM `episodes`
WHERE episode_in_season = 1;
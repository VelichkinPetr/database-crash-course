-- Найти названия эпизодов которым ещё не задана тема (topic)
SELECT `title` FROM `episodes`
WHERE `topic` IS NULL;


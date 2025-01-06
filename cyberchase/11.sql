-- Вывести заголовки эпизодов начиная с сезона №5 в обратном алфавитном порядке
SELECT `title` FROM `episodes`
WHERE `season` = 5 
ORDER BY `title` DESC;


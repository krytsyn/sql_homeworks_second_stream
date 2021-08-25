--Задание 1: Вывести name, class по кораблям, выпущенным после 1920

select name, class, launched
from Ships
where launched >= 1920

--Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942

select name, class, launched
from Ships
where launched >= 1920 and launched <=1942

--Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class

select count(name), class
from Ships
group by class

--Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)

select class, country from classes
where bore >= 16

--Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.

select ship
from outcomes
where battle = 'North Atlantic' and result = 'sunk'
group by ship

--Задание 6: Вывести название (ship) последнего потопленного корабля

SELECT ship, battle, date
FROM outcomes t1 JOIN battles t2 ON t1.battle=t2.name
WHERE result = 'sunk' AND date in
( 
	SELECT max(date)
	FROM battles
)


--Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля



--Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class

select ship, a.class
from ships a join outcomes b on a.name=b.ship
join classes c on a.class=c.class
where result = 'sunk' and bore >=16

--Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class

select class from classes
where country = 'USA'

--Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class

select name, b.class from ships a
join classes b on a.class=b.class
where country = 'USA'

--task17
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select a.name from battles a
join outcomes b on a.name=b.battle
join ships c on b.ship=c.name
where class= 'Kongo'

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select class, count(ship)
from outcomes d
full join ships e on d.ship=e.name
where result = 'sunk'
group by class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select class, min(launched) from ships
group by class

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

select class, count(ship)
from ships a 
full join outcomes b on a.name=b.ship 
group by result, class
having result = 'sunk' and count(ship) >= 3

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

select * 
from 
(
	select *, b.name,
	row_number () over (partition by displacement order by numguns desc) as rn
	from classes a
	join ships b on a.class=b.class
) a 
where rn = 1

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select maker
from
(
	select maker,
	rank () over (partition by ram) as rn,
	dense_rank () over (partition by speed) as dr
	from pc a 
	join product b on a.model=b.model 
) a
join printer c on model=c.model

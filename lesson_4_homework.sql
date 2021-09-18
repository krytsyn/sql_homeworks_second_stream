--task10 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по каждому производителю график (X: category_price, Y: count)

select category_price, count as category_count
from products_price_categories_with_makers p

--task11 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по A & D график (X: category_price, Y: count)

select category_price, count as category_count
from products_price_categories_with_makers p
where maker = 'A'
union all
select category_price, count as category_count
from products_price_categories_with_makers p
where maker = 'D'


--task12 (lesson4)
-- Корабли: Сделать копию таблицы ships, но у название корабля не должно начинаться с буквы N (ships_without_n)

create table ships_without_n as
select name from ships
where name not like 'N%'

select * from ships_without_n


--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select model, maker, type
from product

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"

select printer.code, printer.model, printer.color, printer.type, printer.price,
case
	when printer.price > avg(pc.price)
	then 1
	else 0
end flag  
from printer
join product on printer.model=product.model
join pc on product.model=pc.model
group by printer.code, printer.model, printer.color, printer.type, printer.price

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select * from ships
where class is NULL

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.

select name from battles where DATEPART(yy, date) not in (select DATEPART(yy, date) 
from battles join ships on DATEPART(yy, date)=launched)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select * from outcomes o 
join battles b on o.battle=b.name
join ships s on o.ship=s.name
where class = 'Kongo'

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as
select model, price, flag
from (
select *, 
case 
	when price > 300 then 1
	else 0 
end flag
from all_product
) a

select * from all_products_flag_300 

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price as
select model, price, flag
from (
select *,
case 
	when price > (select avg(price) from all_product) then 1
	else 0
end flag
from all_product
) a

select * from all_products_flag_avg_price
	

--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select p.model from printer p 
join product pr on p.model = pr.model 
where maker ='A' and price > 
( select avg(price) from printer p join product pr on p.model=pr.model where maker = 'D' and maker = 'C'
)

--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select model
from all_product
where maker = 'A' and price >
(select avg(price) from printer p join product pr on p.model=pr.model where maker = 'D' and maker = 'C'
)


--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)

select avg(price) from all_product
where maker = 'A' and 
model in ( select distinct model from product )

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create or replace view count_products_by_makers as
select maker, count(model)
from all_product
group by maker

select * from count_products_by_makers

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

select maker, count from count_products_by_makers

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

create table printer_updated as
select code, p.model, color, p.type, price, maker from printer p
join product pr on p.model=pr.model
where maker != 'D'

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)

create view printer_updated_with_makers as
select code, model, color, type, price, maker
from printer_updated

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

create view sunk_ships_by_classes as
select count(o.ship), o.ship, s.class from outcomes o
join ships s on o.ship=s.name
group by class, o.ship 

--task11.2 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

select class, count from sunk_ships_by_classes

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0

create table classes_with_flag as
select *,
case
	when numguns >= 9
	then 1
	else 0
end flag
from classes

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

select country, count(class) from classes
group by country

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select count(name)
from ships
where name like 'O%' and name like 'M%'

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

select count(name) from ships
where name like '% %'

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)

select launched, count(name) from ships
group by launched

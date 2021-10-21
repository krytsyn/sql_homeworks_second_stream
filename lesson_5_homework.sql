--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). 
--Вывод: все данные из laptop, номер страницы, список всех страниц

create view pages_all_products as
select *, row_number() over (partition by num_page)
from (
	select *, 
	case 
		when code % 2 = 0 then code / 2
		when code % 2 = 1 then (code + 1) / 2
	end num_page
	from laptop 
) a

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства.
-- Вывод: производитель, тип товара, процент

create view distribution_by_type as
select maker, type, count(*)*100 / sum(count(*))over() as percent
from product
group by maker, type

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму

--Файл task3 (lesson5).ipynb
select maker,percent from distribution_by_type;

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но у название корабля должно состоять из двух слов

create table ships_two_words as
select * from ships
where name like '% %'

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select * from ships
where class is NULL
and name like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model

select printer.model 
from printer 
join product
on printer.model = product.model 
where maker = 'A' and price > (
	select avg(price)
	from product  
	join printer 
	on product.model = printer.model 
	where maker = 'C'
)
union all
select model from (
select model, row_number() over (order by price) as rn 
from printer 
) a 
where rn < 4
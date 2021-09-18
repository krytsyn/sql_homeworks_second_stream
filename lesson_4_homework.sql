--task10 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers �� ������� �� ������� ������������� ������ (X: category_price, Y: count)

select category_price, count as category_count
from products_price_categories_with_makers p

--task11 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers �� ������� �� A & D ������ (X: category_price, Y: count)

select category_price, count as category_count
from products_price_categories_with_makers p
where maker = 'A'
union all
select category_price, count as category_count
from products_price_categories_with_makers p
where maker = 'D'


--task12 (lesson4)
-- �������: ������� ����� ������� ships, �� � �������� ������� �� ������ ���������� � ����� N (ships_without_n)

create table ships_without_n as
select name from ships
where name not like 'N%'

select * from ships_without_n


--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type

select model, maker, type
from product

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"

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
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)

select * from ships
where class is NULL

--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.

select name from battles where DATEPART(yy, date) not in (select DATEPART(yy, date) 
from battles join ships on DATEPART(yy, date)=launched)

--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select * from outcomes o 
join battles b on o.battle=b.name
join ships s on o.ship=s.name
where class = 'Kongo'

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag

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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag

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
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

select p.model from printer p 
join product pr on p.model = pr.model 
where maker ='A' and price > 
( select avg(price) from printer p join product pr on p.model=pr.model where maker = 'D' and maker = 'C'
)

--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

select model
from all_product
where maker = 'A' and price >
(select avg(price) from printer p join product pr on p.model=pr.model where maker = 'D' and maker = 'C'
)


--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)

select avg(price) from all_product
where maker = 'A' and 
model in ( select distinct model from product )

--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count

create or replace view count_products_by_makers as
select maker, count(model)
from all_product
group by maker

select * from count_products_by_makers

--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

select maker, count from count_products_by_makers

--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'

create table printer_updated as
select code, p.model, color, p.type, price, maker from printer p
join product pr on p.model=pr.model
where maker != 'D'

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)

create view printer_updated_with_makers as
select code, model, color, type, price, maker
from printer_updated

--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)

create view sunk_ships_by_classes as
select count(o.ship), o.ship, s.class from outcomes o
join ships s on o.ship=s.name
group by class, o.ship 

--task11.2 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

select class, count from sunk_ships_by_classes

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

create table classes_with_flag as
select *,
case
	when numguns >= 9
	then 1
	else 0
end flag
from classes

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)

select country, count(class) from classes
group by country

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".

select count(name)
from ships
where name like 'O%' and name like 'M%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.

select count(name) from ships
where name like '% %'

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)

select launched, count(name) from ships
group by launched

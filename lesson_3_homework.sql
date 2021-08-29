--task17
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select a.name from battles a
join outcomes b on a.name=b.battle
join ships c on b.ship=c.name
where class= 'Kongo'

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.

select class, count(ship)
from outcomes d
full join ships e on d.ship=e.name
where result = 'sunk'
group by class

--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.

select class, min(launched) from ships
group by class

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.

select class, count(ship)
from ships a 
full join outcomes b on a.name=b.ship 
group by result, class
having result = 'sunk' and count(ship) >= 3

--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).

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
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker

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

--������� 1: ������� name, class �� ��������, ���������� ����� 1920

select name, class, launched
from Ships
where launched >= 1920

--������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942

select name, class, launched
from Ships
where launched >= 1920 and launched <=1942

--������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class

select count(name), class
from Ships
group by class

--������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)

select class, country from classes
where bore >= 16

--������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.

select ship
from outcomes
where battle = 'North Atlantic' and result = 'sunk'
group by ship

--������� 6: ������� �������� (ship) ���������� ������������ �������

SELECT ship, battle, date
FROM outcomes t1 JOIN battles t2 ON t1.battle=t2.name
WHERE result = 'sunk' AND date in
( 
	SELECT max(date)
	FROM battles
)


--������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������



--������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class

select ship, a.class
from ships a join outcomes b on a.name=b.ship
join classes c on a.class=c.class
where result = 'sunk' and bore >=16

--������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class

select class from classes
where country = 'USA'

--������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class

select name, b.class from ships a
join classes b on a.class=b.class
where country = 'USA'

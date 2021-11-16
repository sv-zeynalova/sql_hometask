--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing
select *
-- ������� 1: ������� name, class �� ��������, ���������� ����� 1920
select name, class 
from ships 
where launched > 1920

-- ������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
select name, class
from ships 
where launched > 1920 and launched <=1942
-- ������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class
select count (distinct ships), class
from ships
group by class

-- ������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)
select class, country
from classes where bore >=16

-- ������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.
select ship
from outcomes
where battle = 'North Atlantic' and result = 'sunk'


-- ������� 6: ������� �������� (ship) ���������� ������������ �������
select ship
from outcomes
join battles
on outcomes.battle = battles.name
where result = 'sunk'
and date = (select max(date) from battles)

 
-- ������� 7: ���e��� �������� ������� (ship) � ����� (class) ���������� ������������ �������

select ship,class
from outcomes
join ships
on outcomes.ship = ships.name
where result = 'sunk'
and ship in(
select ship
from outcomes
join battles
on outcomes.battle = battles.name
where date = (select max(date) from battles where result = 'sunk')
)


-- ������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class

select name, ships.class, bore
from classes
join ships
on classes.class = ships.name
where bore >=16 
and name in(
select ship
from outcomes
join battles
on outcomes.battle = battles.name
where result = 'sunk')

-- 2 �������
select ship, class
from classes
join outcomes
on classes.class = outcomes.ship
where result = 'sunk'
and bore >=16

-- ������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class
select class
from classes 
where country = 'USA'
group by class

-- ������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class

select name, ships.class
from classes
join ships
on classes.class = ships.name
where country = 'USA'


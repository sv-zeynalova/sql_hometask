--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
select class, count(name)
from(
select classes.class, name
from classes
join ships
on classes.class = ships.name
union 
select class, name
from ships
join outcomes
on ships.name = outcomes.ship 
) a
where name in (select ship from outcomes where result = 'sunk')
group by class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select class, min(launched)
from (
select name, class, launched
from ships
union
select class, class, null 
from classes) a
group by class


--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.


select class, count(ship)
from(
select class, ship
from classes
join outcomes
on classes.class = outcomes.ship
where result='sunk'
union
select class, ship 
from outcomes
join ships
on ships.name = outcomes.ship 
where result='sunk'
) a
where class in 
( select distinct X.class , count(*)
     from  (
     select class, ship 
     from classes 
     join outcomes 
     on classes.class = outcomes.ship 
     union 
     select ships.class,name 
     from classes 
     join ships 
     on classes.class=ships.class) as X 
group by X.class 
having count(X.class)>=3 ) 
group by class 

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

select NAME from(
select name as NAME, displacement, numguns  
from ships
join classes 
on ships.class = classes.class 
union 
select ship as NAME, displacement, numguns 
from outcomes 
join classes 
on outcomes.ship= classes.class) as d1 
join (select displacement, max(numguns) as numguns
      from ( 
            select displacement, numguns 
            from ships 
            join classes 
            on ships.class = classes.class  
            union 
            select displacement, numguns  
            from outcomes
            join classes 
            on outcomes.ship= classes.class) as f
      group by displacement) as d2
      on d1.displacement=d2.displacement and d1.numguns = d2.numguns
 
      

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker


with pc_1 as
(select product.maker, speed, ram
from product
join pc
on product.model = pc.model
where ram = (select min(ram) from pc)
)
select product.maker
from printer
join product
on product.model = printer.model
where product.maker in(
select maker from pc_1 where speed = (select max(speed) from pc_1)
)


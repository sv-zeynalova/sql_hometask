--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select model, maker, type
from(
select product.model, maker, product.type  
from pc 
join product 
on pc.model = product.model 
union all 
select product.model, maker, product.type  
from printer 
join product 
on printer.model = product.model 
union all 
select product.model, maker, product.type  
from laptop 
join product 
on laptop.model = product.model 
) a

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"

select *, 
case 
    when price > (select avg(price) from pc) then 1
    else 0
    end flag
from printer

select avg(price)
from pc

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select name
from (
select name, class
from ships 
union
select distinct ship, NULL as class
from Outcomes) a
where class is null

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие  с одeним из годов спуска кораблей на воду.

with q1 as (
select name, extract(year from date) as year 
from battles 
)
select *
from q1 
where year not in (select launched from ships)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select distinct battle 
from outcomes
where ship in 
(select name
from ships 
where class = 'Kongo')

--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select product.model
from product 
join printer 
on product.model = printer.model 
where maker = 'A'
and printer.price > (
  select avg(price) 
  from(
  select price
  from product
  join printer 
  on product.model = printer.model 
  where maker = 'D'
  union all
  select price
  from product
  join printer 
  on product.model = printer.model 
  where maker = 'C'
   ) a
)

--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model


--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
select avg(price)
from
(
    select price
    from PC 
    join product
    on pc.model = product.model 
    where maker = 'A'
  union 
    select price
    from printer 
    join product
    on printer.model = product.model 
    where maker = 'A'
  union 
    select price
    from laptop 
    join product
    on laptop.model = product.model
    where maker = 'A'
)  a

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create view count_products_by_makers as
select maker, count(*)
from(
select  maker
from pc 
join product 
on pc.model = product.model 
union all 
select  maker
from printer
join product 
on printer.model = product.model 
union all 
select  maker
from laptop 
join product 
on laptop.model = product.model 
) a
group by maker

select *
from count_products_by_makers

--task7 (lesson4)
--По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

create table printer_updated as
select *
from(
select code, printer.model, color, printer.type, price
from product 
join printer
on product.model = printer.model
where maker not in (select maker from product where maker = 'D')
)a


--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)

create view printer_updated_with_makers as
select *
from(
select code, maker, printer.model, color, printer.type, price
from product
join printer
on product.model = printer.model
) a
where maker not in (select maker from product where maker = 'D')

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

drop view sunk_ships_by_classes
create view sunk_ships_by_classes as
select class, count(ship)
from(
      select name as ship, class
      from ships 
      union all
      select ship , 'No name' as class
      from Outcomes
) a
where ship in (
select ship
from outcomes
where result = 'sunk')
group by class

select *
from sunk_ships_by_classes

--task11 (lesson4)p 
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

--task12 (lesson4), 
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0

create table classes_with_flag as
select *,
case when numguns >=9 then 1
else 0
end flag
from classes

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

select country, count(class)
from classes
group by country

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".
with all_ships as 
(select name from ships
union
select ship as name from outcomes)
    select 
    (select count(name)
    from all_ships
    where name like 'O%')
    +
    (select count(name) 
    from all_ships
    where name like 'M%')
    
--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
    
select count(name) from ships
where name like '% %'
union
select count(ship) from outcomes
where ship like '% %'

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)

select count(name), launched
from ships
group by launched
order by launched
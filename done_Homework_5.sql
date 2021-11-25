--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ �������� ���� ��������� (�� ����� ���� ��������� �� �����
-- ��������). �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

sample:
1 1
2 1
1 2
2 2
1 3
2 3
create view pages_all_products as
with laptop_paging as(
SELECT *,
      
      CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page
    
FROM (select *,
      ROW_NUMBER() OVER(ORDER BY price DESC) AS num    
      FROM Laptop
     ) a
     )
         select *,
         ROW_NUMBER() OVER(partition by page ORDER BY page) AS place
         from laptop_paging
         
         
         
         
         
with q1 as(
SELECT *,
      
      CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page
    
FROM (select *,
      ROW_NUMBER() OVER(ORDER BY price DESC) AS num, 
      COUNT(*) OVER() AS total    
      FROM Laptop
     ) X
     )
         select *,
         ROW_NUMBER() OVER(partition by page ORDER BY page) AS place
         from q1

--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� ����������. �����: �������������, ���, ������� (%)

 create view distribution_by_type as   
    WITH count_type AS (
    SELECT maker, type, count(*) AS sv
    FROM (
    select maker, product.type
    from product 
    join pc on product.model = pc.model 
    union all
    select maker, product.type
    from product 
    join printer on product.model = printer.model 
    union all
    select maker, product.type
    from product 
    join laptop on product.model = laptop.model
    ) a
    GROUP  by maker, type
    )
SELECT *,
 round(
        sv/ sum(sv) OVER (PARTITION BY type)*100 ,0
        ) as share_percent
FROM   count_type;

select * 
from distribution_by_type

--task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������. ������ https://plotly.com/python/histograms/


--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� �������� ������� ������ �������� �� ���� ����
create table ships_two_words as
select *
from ships 
where name like '% %'

--task6 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"
 select name
from (
select name, class
from ships 
union
select distinct ship, NULL as class
from Outcomes) a
where class is null and name like 'S%'
 

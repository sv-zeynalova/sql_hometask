--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, дополнительно)
-- SQL: Создайте таблицу с синтетическими данными (10000 строк, 3 колонки, все типы int) и заполните ее случайными данными от 0 до 1 000 000. Проведите EXPLAIN операции и сравните базовые операции.
create table table_test (
    column1 int,
    column2 int,
    column3 int);
    
explain insert into table_test(column1, column2, column3) 
select (random() *  (1000000-0+1)+0), (random() *  (1000000-0+1)+0), (random() *  (1000000-0+1)+0) 
from generate_series(1,10000);

explain select * 
from table_test

Базовые операции:
insert (cost 0-50.0, 1000 строк)
select (cost 0-50.0, 1000 строк)
generate_series() (cost 0-32.50, 1000 строк)

Вся таблица :
seq scan 0-155.0, 10000 строк

--Дополнительно)
-- GCP (Google Cloud Platform): Через GCP загрузите данные csv в базу PSQL по личным реквизитам (используя только bash и интерфейс bash) 

select * 
from avocado_test
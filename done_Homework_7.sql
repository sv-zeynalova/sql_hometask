--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонок
create table table_1 (
  
    r1 int,
    r2 int,
    r3 int);
   insert into table_1(r1, r2, r3) 
select (random() *  (1000-0+1)+0), (random() *  (1000-0+1)+0), (random() *  (1000-0+1)+0) 
from generate_series(1,1000);
select * from table_1

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

select email
from  Person a
where (select count(email) from Person b
where a.email = b.email) > 1
group by email

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

select a.name as Employee
from employee a
join employee manager on a.managerId = manager.id
where a.salary > manager.salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

SELECT score, 
DENSE_RANK() OVER(order by score DESC) rank
FROM Scores;

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select * from address
SELECT 
p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a
ON p.personId = a.personId;


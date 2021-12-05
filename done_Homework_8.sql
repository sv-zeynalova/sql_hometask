--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
WITH q1 AS (
           SELECT d.name as Department, e.name as Employee, salary,
           DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) AS RowNum
           FROM Employee e
           join Department d
           on e.departmentid = d.id)        
SELECT Department, Employee, salary
    FROM q1
    WHERE RowNum <= 3;

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select member_name, status, sum(amount*unit_price) as costs 
from FamilyMembers 
join Payments 
on FamilyMembers.member_id = Payments.family_member
where Payments.date between '2005-01-01' and '2006-01-01'
GROUP BY member_name, status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
SELECT name 
FROM Passenger
GROUP BY name
HAVING COUNT(name) > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT COUNT(first_name) as COUNT
from Student
where first_name ='Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

SELECT DISTINCT count(classroom) as count
from Schedule
where date like '2019-09-02%'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT COUNT(first_name) as COUNT
from Student
where first_name ='Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

SELECT round (AVG(YEAR(CURRENT_DATE) - YEAR(birthday)),0) AS age
FROM FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

SELECT good_type_name, SUM(amount*unit_price) AS costs
FROM GoodTypes
JOIN Goods 
ON GoodTypes.good_type_id = Goods.type
JOIN Payments 
ON Goods.good_id = Payments.good
WHERE YEAR(date)='2005'
GROUP BY good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

SELECT TIMESTAMPDIFF(YEAR, (SELECT MAX(birthday)
FROM Student), CURDATE()) AS year 

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

SELECT MAX(TIMESTAMPDIFF(YEAR,birthday,CURRENT_DATE)) AS max_year
FROM Student
JOIN Student_in_class
on Student.id = Student_in_class.student
JOIN Class
on Student_in_class.class = Class.id
where name like '10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
 
SELECT status,member_name,SUM(amount*unit_price) as costs
from FamilyMembers
JOIN Payments
on FamilyMembers.member_id = Payments.family_member
JOIN Goods
on Payments.good = Goods.good_id
JOIN GoodTypes 
on Goods.type=GoodTypes.good_type_id
where good_type_name = 'entertainment'
GROUP BY status, member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55  --решение верно, непонятен вывод результата!! вывод 2х компаний из таблицы Company

DELETE FROM Company
WHERE Company.id IN(
      with q1 as(
      SELECT COUNT(id) as count
      from Trip
      GROUP BY company)
          SELECT MIN(count)  from q1
          )

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
          
with q1 as(
SELECT classroom, COUNT(classroom), 
RANK() OVER(ORDER BY COUNT(classroom) DESC )as rnk
FROM Schedule
GROUP BY classroom)
SELECT classroom FROM q1
WHERE rnk = 1

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

SELECT  last_name
FROM Teacher
JOIN Schedule
ON Teacher.id=Schedule.teacher
JOIN Subject
ON Schedule.subject = Subject.id
WHERE Subject.name = 'Physical Culture'
ORDER BY last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

SELECT CONCAT ( 
last_name, '.', 
LEFT(first_name, 1), '.',
LEFT (middle_name,1),'.' 
) as name
FROM Student
ORDER BY last_name,first_name

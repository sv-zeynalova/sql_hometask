--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT
   CASE WHEN G.Grade > 7 THEN S.Name ELSE 'NULL' end,
     G.Grade,
     S.Marks
FROM Students S
JOIN Grades G ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark
ORDER BY G.Grade DESC, S.Name ASC, S.Marks ASC;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

select doctor,professor,singer,actor 
from (
   select * 
   from (
        select Name, occupation, 
        (ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name)) as rn
        from occupations order by name asc
        ) 
        pivot 
        ( min(name) for occupation in ('Doctor' as doctor,'Professor' as professor,'Singer' as singer,'Actor' as actor)
     ) order by rn);
    
--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
    
select distinct city
from Station
where regexp_like(city, '^[^aeiouAEIOU].*');


--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

select distinct city
from Station
where regexp_like(city, '*[^aeiou]$');

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

select distinct city
from Station
where regexp_like(city, '^[^aeiouAEIOU]|.*[^aeiou]$');

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

select distinct city
from Station
where regexp_like(city, '^[^aeiouAEIOU].*[^aeiou]$');

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select name from
(select name, employee_id
from Employee
where salary>=2000 and months <10)
order by employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

--это дубль task1

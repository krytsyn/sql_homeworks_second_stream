--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

select case when (students.marks < 70) then 'null' else students.name end,grades.grade,dtudents.marks
from students, grades where students.marks >= grades.min_mark and students.marks <= grades.max_mark order by grades.grade desc, students.name asc;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

select Doctor, Professor, Singer, Actor from
    (select Name,Occupation,
        row_number() over(partition by Occupation order by Name) as rn
    from Occupations)
pivot(min(Name) for Occupation in ('Doctor' as Doctor, 'Professor' as Professor, 'Singer' as Singer, 'Actor' as Actor))
order by rn;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

select distinct city from station where city Not like 'A%' and city Not like 'E%' and city Not like 'I%' and city Not like 'O%' and city not like 'U%';

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

select distinct city from station where city Not like '%a' and city Not like '%e' and city Not like '%i' and city Not like '%o' and city not like '%u';

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

select distinct city 
from STATION 
where upper(substr(city, 0, 1)) not in ('E', 'U', 'I', 'O', 'A')
or upper(substr(city, -1, 1)) not in ('E', 'U', 'I', 'O', 'A');

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

select distinct city
from station
where city not like 'A%' and
city not like 'E%' and
city not like 'I%' and
city not like 'O%' and
city not like 'U%' and
city not like '%a' and
city not like '%e' and
city not like '%i' and
city not like '%o' and
city not like '%u';

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select name from Employee where salary>2000 and months<10 order by employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

select 
    case when grade > 7 then Name
    else Null
    end Name,
    Grade, Marks from Students
JOIN Grades ON Students.Marks BETWEEN Min_Mark AND Max_Mark
order by grade desc, Name, Marks;
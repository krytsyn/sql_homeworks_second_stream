--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select d.Name as Department, a.Name as Employee, a.Salary 
from (
select e.*, dense_rank() over (partition by DepartmentId order by Salary desc) as Rank 
from Employee e 
) a 
join Department d
on a.DepartmentId = d.Id 
where Rank <=3

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

SELECT fm.member_name, fm.status, SUM(p.amount*p.unit_price) as costs
FROM FamilyMembers as fm
JOIN Payments as p ON p.family_member = fm.member_id
WHERE YEAR(p.date) = 2005
GROUP BY fm.member_id, fm.member_name, fm.status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

SELECT name FROM Passenger group by name HAVING COUNT(name)>1 

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT COUNT(*) as count from Student WHERE first_name='Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

SELECT COUNT(classroom) as count from  Schedule where date = '2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT COUNT(*) as count from Student WHERE first_name='Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

SELECT round(avg((to_days(now()) - to_days(birthday)) / 365.25)-1) as age from FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

SELECT good_type_name, SUM(amount*unit_price) as costs
from GoodTypes
JOIN Goods ON good_type_id=type
JOIN Payments ON good_id=good
WHERE YEAR(date)=2005
GROUP BY good_type_name 

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

SELECT MIN(TIMESTAMPDIFF(YEAR,birthday,CURRENT_DATE)) AS year
FROM Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

SELECT MAX(TIMESTAMPDIFF(year, birthday, current_date)) as max_year
from Student join Student_in_class on Student.id= Student_in_class.student
join Class on Student_in_class.class=Class.id
where class.name LIKE '10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

    SELECT fm.status, fm.member_name, SUM(p.amount*p.unit_price) AS costs
FROM FamilyMembers AS fm
JOIN Payments AS p
    ON fm.member_id=p.family_member
JOIN Goods AS g
    ON p.good=g.good_id
JOIN GoodTypes AS gt
    ON g.type=gt.good_type_id
WHERE good_type_name = 'entertainment'
GROUP BY fm.status, fm.member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

DELETE FROM Company
WHERE Company.id IN (
    SELECT company FROM Trip
    GROUP BY company
    HAVING COUNT(id) = (SELECT MIN(count) FROM (SELECT COUNT(id) AS count FROM Trip GROUP BY company) AS min_count)
    )

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

SELECT classroom 
FROM Schedule
GROUP BY classroom
HAVING COUNT(classroom) = 
    (SELECT COUNT(classroom) 
     FROM Schedule 
     GROUP BY classroom
     ORDER BY COUNT(classroom) DESC 
     LIMIT 1)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select last_name from Teacher 
join Schedule ON Teacher.id = Schedule.teacher
join Subject on Subject.id=Schedule.subject
where Subject.name='Physical Culture'
ORDER BY Teacher.last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

 SELECT CONCAT(last_name, '.', LEFT(first_name, 1), '.', LEFT(middle_name, 1), '.') as name
 from Student ORDER BY last_name, first_name
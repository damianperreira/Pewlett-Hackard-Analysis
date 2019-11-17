--Part 1 Mod 7 Challenge
--Number of [titles] Retiring
--birth_date in 1965 create table number_of_titles_retiring

drop table number_of_titles_retiring;
select 
e.emp_no,
e.first_name,
e.last_name,
t.title as title,
t.from_date,
s.salary
into number_of_titles_retiring
from Employees e 
right join titles t on (e.emp_no = t.emp_no) --used right join as indicated
join salaries s on (e.emp_no = s.emp_no)
where e.birth_date between '1965-01-01' and '1965-12-31' -- birth date 
and t.to_date > '2019-11-15' -- current employees only
order by 2,3;


--Only the Most Recent Titles
drop table frequency_count_of_titles;
--count employees by title and export to csv
select x.title, count(*) as counts into frequency_count_of_titles from
(--remove duplicates and get the most recent title grouping by first and last name
SELECT * FROM
  (SELECT row_number() OVER (PARTITION BY emp_no,first_name, last_name order by from_date desc) AS recenttitle,*
FROM number_of_titles_retiring) recenttitles
  WHERE recenttitles.recenttitle = 1 order by from_date desc) x group by x.title
  ;

--Who’s Ready for a Mentor?
/*Create a new table that contains the following information:
Employee number
First and last name
Title
from_date and to_date
Note: The birth_date date needs to be between January 1, 1965 and December 31, 1965. 
Also, make sure only current employees are included in this list.*/

drop table ready_for_a_mentor;
--create table only active employees (where to_date on recent title is >= current date)
select x.* into ready_for_a_mentor from 
(
select 
e.emp_no,e.first_name,e.last_name,
t.title,t.from_date,t.to_date,
row_number() OVER (PARTITION BY e.emp_no,e.first_name, e.last_name order by t.from_date desc) AS recenttitle
from
employees e 
join titles t on (e.emp_no = t.emp_no)
where e.birth_date between '1965-01-01' and '1965-12-31'
AND t.to_date > '2019-11-15') x where recenttitle = 1
;

--explore
select * from ready_for_a_mentor;




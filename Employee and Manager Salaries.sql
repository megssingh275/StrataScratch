/*
MEDIUM
Employee and Manager SalariesHighest Number Of Orders
Walmart

Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.

Table: employee


*/


select a.first_name, a. salary from employee a inner join employee b
on a.manager_id = b.id
group by 1
having sum(a.salary)> sum(b.salary)
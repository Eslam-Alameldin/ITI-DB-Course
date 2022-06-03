
use Company_SD

1------------------
select * from Employee

2-----------------
select Fname, Lname, Salary, Dno
from Employee

3--------------
select Pname,Plocation, Dnum
from Project

4------------------
select Fname +Lname as fullname ,(Salary*12)+(.1*Salary) as Annualcomm
from Employee

5---------------------------
select SSN, Fname + ' '+Lname as fullname 
from Employee
where Salary > 1000

6-----------------------
select SSN, Fname + ' '+Lname as fullname 
from Employee
where(Salary*12) > 10000

7-----------------------
select Fname , Salary 
from Employee
where Sex = 'F'

8----------------------
8.	Display each department id, name which managed by a manager with id equals 968574

select Dnum ,Dname 
from Departments
where MGRSSN = 968574

9.	Dispaly the ids, names and locations of  the pojects which controled with department 10.

select Pname , Pnumber, Plocation
from Project
where Dnum =10

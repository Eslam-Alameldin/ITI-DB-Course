use Company_SD

--1.	Display (Using Union Function)
-------a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.'
-------b.	 And the male dependence that depends on Male Employee.

select d.Dependent_name , d.Sex
from Dependent d inner join Employee e
on SSN=ESSN and  d.Sex = 'F' and e.Sex = 'F'
union 
select d.Dependent_name , d.Sex
from Dependent d inner join Employee e
on SSN=ESSN and d.Sex = 'M' and e.Sex = 'M'

--2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.

select Pname , sum(hours) as totalhours
from Project , Works_for
where Pnumber= Pno
group by Pname

--3.	Display the data of the department which has the smallest employee ID over all employees' ID.

select d.* 
from Departments d , Employee e
where Dnum= Dno and ssn = (select min(SSN) from Employee)

--4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.

select d.Dname , max(salary) as max , min(salary) as min , avg(salary) as avg
from Departments d , Employee e 
where Dnum= Dno
group by d.Dname

--5.	List the last name of all managers who have no dependents.

select  distinct Fname 
from Employee e inner join Departments d 
on SSN=MGRSSN 
left join Dependent
on SSN= ESSN
where ESSN is null

--6.	For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.

select Dnum , Dname , count(ssn) as [number of employees]
from Employee e inner join Departments d
on Dnum= Dno
group by Dnum , Dname
having AVG(Salary) < (select AVG(salary) from employee)

--7.	Retrieve a list of employees and the projects they are working on ordered by department and within each department, 
--------ordered alphabetically by last name, first name.

select Fname, Lname, pname 
from Employee e inner join Departments d 
on Dnum = Dno
inner join Project p 
on d.Dnum = p.Dnum
order by d.Dnum ,Lname, Fname

--8.	Try to get the max 2 salaries using subquery

select MAX (salary) from Employee
union all 
select max (salary) from Employee
      where Salary not in (select MAX(Salary) from Employee)

--another solution
select top(2) salary 
from Employee
order by Salary desc

--9.	Get the full name of employees that is similar to any dependent name

select fname + ' ' + lname as fullname 
from Employee
intersect 
select Dependent_name
from Dependent

--10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%

update Employee
set Salary = Salary*1.3
from Employee , Works_for, Project
where SSN= ESSn and Pnumber= Pno and Pname = 'Al Rabwah'




--1.	In the department table insert new department called "DEPT IT" , with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'
 insert into Departments
values('DEPT IT',100,112233,11/1/2006)


--2.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 

---a.	First try to update her record in the department table
---b.	Update your record to be department 20 manager.
---c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

update Departments
set MGRSSN = 968574
where Dnum = 100

update Departments
set MGRSSN = 102672
where Dnum = 20

update Employee
set Superssn = 102672
where SSN= 102660

--3.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
-----Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).

delete Dependent where ESSN=223344
delete Works_for where ESSN=223344

update Departments set MGRSSN=102672 where MGRSSN=223344;

update Employee set Superssn = 102672  where Superssn=223344;

delete Employee where SSN=223344
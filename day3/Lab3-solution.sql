

1.	Display the Department id, name and id and the name of its manager.

select Dname , Dnum , MGRSSN, Fname
from Departments inner join Employee
 on SSN = MGRSSN

2.	Display the name of the departments and the name of the projects under its control.

select Dname, Pname
from Departments d , Project p
where d.Dnum = p.Dnum

3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.

select d.* , Fname 
from Dependent d,Employee
where SSN = ESSN

4.	Display the Id, name and location of the projects in Cairo or Alex city.

select Pnumber, pname , plocation 
from Project
where City in ('Alex','Cairo')

5.	Display the Projects full data of the projects with a name starts with "a" letter.

select * 
from Project 
where pname like 'a%'


6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly

select * 
from employee
where Dno = 30 and Salary between 1000 and 2000

7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.

select Fname , Lname 
from Employee inner join works_for 
on SSN = ESSN
inner join Project 
on pnumber = Pno
where pname = 'AL Rabwah' and hours >= 10

8.	Find the names of the employees who directly supervised with Kamel Mohamed.

select e.fname +' ' + e.lname as empname
from employee s  inner join employee e
on s.ssn = e.superssn
where s.Fname = 'Kamel' and s.Lname ='Mohamed'


9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.

select fname + ' ' + lname as empname , pname
from employee e inner join works_for w
on ssn = essn
inner join project p
on pnumber = pno
order by pname


10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.

select pnumber,dname, fname , address, bdate
from project p inner join Departments d
on d.Dnum = p.Dnum
inner join employee e
on ssn = mgrssn
where city = 'Cairo'

11.	Display All Data of the mangers

select *
from employee inner join departments 
on ssn = mgrssn


12.	Display All Employees data and the data of their dependents even if they have no dependents


select *
from Employee e left outer join Dependent
on ssn=essn


Data Manipulating Language:

1.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.

insert into employee (ssn,superssn,salary,Dno)
values(102672,112233,3000,30)

2.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660,
but don’t enter any value for salary or manager number to him.

insert into Employee(Fname,Lname,SSN,Bdate,Address,Sex,Dno)
values('ahmed','refaat',102660,8/20/1995,'zefta','m',30)

3.	Upgrade your salary by 20 % of its last value

update employee
set Salary = (Salary+.2*Salary)
where SSN=102672
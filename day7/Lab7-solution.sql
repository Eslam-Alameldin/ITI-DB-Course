
--1.	 Create a scalar function that takes date and returns Month name of that date.

create function get_mon_name (@date date)
returns varchar(10)
begin
declare @monthnam varchar(10)
if month(@date) = 1
 select @monthnam = 'jan'
if month(@date)=2
  select @monthnam = 'feb'
if month(@date)=3
  select @monthnam = 'mar'
if month(@date)=4
  select @monthnam = 'apr'
if month(@date)=5
  select @monthnam = 'may'
if month(@date)=6
  select @monthnam = 'jun'
if month(@date)=7
  select @monthnam = 'jal'
if month(@date)=8
  select @monthnam = 'aug'
if month(@date)=9
  select @monthnam = 'sep'
if month(@date)=10
  select @monthnam = 'oct'
if month(@date)=11
  select @monthnam = 'nov'
if month(@date)=12
  select @monthnam = 'dec'

return @monthnam
end

select dbo.get_mon_name ('6/1/2021')

---- another solution
create function get_month_name(@date date)
returns varchar(10)
begin 
declare @name varchar (10)
select @name = format(@date , 'MMMM')
return @name
end 

select dbo.get_month_name('10/5/2012')

--2.	 Create a multi-statements table-valued function that takes 2 integers and returns the values between them.

create function get_mid_values (@val1 int , @val2 int)
returns @t table (val int) 
as 
  begin
  declare @val3 int = @val1+1
  while @val3 < @val2
  begin
    insert into @t select @val3
    set @val3 += 1
  end
  return
  end

select * from get_mid_values(10,15)

--3.	 Create a tabled valued function that takes Student No and returns Department Name with Student full name.

create function get_info(@id int)
returns table 
as 
return 
      (
	  select st_fname + ' ' + st_lname as [student name] , dept_name
	  from Student s , Department d
	  where d.Dept_Id = s.Dept_Id   and  St_Id =@id
	  )

select * from get_info(12)


--4.	Create a scalar function that takes Student ID and returns a message to user 
------a.	If first name and Last name are null then display 'First name & last name are null'
------b.	If First name is null then display 'first name is null'
------c.	If Last name is null then display 'last name is null'
------d.	Else display 'First name & last name are not null'

create function get_message( @id int)
returns varchar(30) 
    begin
	declare @message varchar(50)
	declare @first varchar(20)
	declare @last varchar (20)
	select @first = st_fname from student where st_id = @id
	select @last = st_lname from student where  st_id = @id 
	if @first is null and @last is null
	  select @message ='first name and last name are null'
    else if @first is null 
	  select @message ='first is null'
    else if @last is null
	  select @message =' last name is null'
    else 
	  select @message= 'first name and last name are not null'
    return @message
	end

select dbo.get_message (10)

--5.	Create a function that takes integer which represents manager ID and displays department name, Manager Name and hiring date

create function get_manager_info(@id int)
returns table
as 
return 
  (
   select ins_name,dept_name,manager_hiredate
   from Instructor i,Department d
   where i.Ins_Id=d.Dept_Manager and d.Dept_Manager=@id
  )

  select * from get_manager_info(5)


--6.	Create multi-statements table-valued function that takes a string
----If string='first name' returns student first name
----If string='last name' returns student last name 
----If string='full name' returns Full Name from student table 
----Note: Use “ISNULL” function

create function get_studname (@string varchar(30))
returns @t table 
               (
			    name varchar(50)
			   )
as 
     begin
	 if @string = 'first name '
	   insert into @t
	   select ISNULL(st_fname,' ') from student
	 if @string = 'last name'
	  insert into @t
	  select ISNULL(st_lname, ' ') from Student
	if @string = 'full name' 
	 insert into	@t
	 select ISNULL(st_fname + ' '+ st_lname, ' ') from Student
	return
     end

	 select * from get_studname ('full name')



Create Database P228SqlConstraint

Use P228SqlConstraint

Create Table Students
(
	Id int identity primary key,
	Name nvarchar(100) Constraint NN_STU_NAME Not Null,
	SurName nvarchar(100) Not Null,
	Email nvarchar(100) Not Null Constraint UNQ_Stu_Email Unique,
	Age TinyInt Not Null Constraint CK_STU_AGE Check(Age > 18 AND Age < 40),
	Grade TinyInt Not Null Check(Grade <= 100)
)

Drop Table Students

Alter Table Students Drop Constraint PK_Stu_ID

Alter Table Students Drop Constraint CK_STU_AGE

Alter Table Students Drop Constraint CK__Students__Grade__48CFD27E

Alter Table Students Add Constraint CK_STUDENTS_AGE Check(Age >= 15 AND Age <= 40)

Alter Table Students Add constraint CK_STUDENTS_GRADE Check(Grade <= 100)

Alter Table Students Add CreatedBy nvarchar(100)

Alter Table Students Add Constraint DF_STU_CreatedBy Default 'System' For CreatedBy

Create Table Groups
(
	Id int identity primary key,
	Name nvarchar(4) Not Null Unique Check(Len(Name)=4)
)

Alter Table Students Add GroupId int Not Null Foreign Key References Groups(Id)

Truncate Table Students

Truncate Table Groups

Insert Into Groups 
Values
('P228'),('P229'),('P128'),('P129')

Insert Into Students(Name, SurName,Age,Email,Grade,GroupId)
Values
('Hamid','Mammadov',32,'hamid@mail.ru',15,6),
('Adil','Suleymanov',22,'adil@gmail.com',25,6),
(N'Rəşad','Ismayılov',22,'rashad@live.com',65,7)

Select Min(Age) From Students 

Select Max(Age) From Students 

Select Avg(Age) From Students 

Select Sum(Age) From Students 

Select Count(*) From Students 

Select LEN(Name) From Students

Select LEN(SurName) From Students

Select SUBSTRING(SurName,5,LEN(SurName)) From Students

Select CHARINDEX('a',SurName,1) From Students

Select REPLACE(SurName,'a','') From Students

Select CHARINDEX('@',Email,1) From Students

Select SUBSTRING(Email,CHARINDEX('@',Email,2)+1,LEN(Email)) From Students

Select * From Students Where Age = (Select MIN(Age) from Students )

Select * From Students Where Grade >(Select Avg(Grade) from Students )

Select distinct Name from Students

Select Name, Count(*) From Students where age > 20 Group By Name Having(Count(*)) >= 2

Select * From Students Where Age >= 16 And Age< 26

Select * From Students Where Age Between 16 And 26

Select * From Students Where Age = 16 Or Age = 26 Or Age = 22

Select * From Students Where Age In(16,26,22,20)

Select * From Students s
Where Exists(Select * From Groups where Name = 'P228' And Id = s.GroupId)

Create Table Employees
(
	Id int identity primary key,
	Ad nvarchar(100),
	Soyad nvarchar(100),
	Yas TinyInt
)

Select Name, SurName, Age From Students 
union
Select Ad 'Name', Soyad 'SurName', Yas 'Age' From Employees

Select Name, SurName, Age From Students 
union all
Select Ad 'Name', Soyad 'SurName', Yas 'Age' From Employees

Select Name From Groups
union
Select Ad 'Name' From Employees

Select * From 
(
	Select Name, SurName, Age From Students 
	union
	Select Ad 'Name', Soyad 'SurName', Yas 'Age' From Employees
) unTable 
where 
unTable.Age >(Select AVG(s.Age) From 
(
	Select Name, SurName, Age From Students 
	union
	Select Ad 'Name', Soyad 'SurName', Yas 'Age' From Employees
) s
)
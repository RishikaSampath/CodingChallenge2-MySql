-- QUESTION 1,2,3 & 4

create table if not exists Companies(CompanyID int primary key,
CompanyName varchar(255),
Location varchar(255));

create table Jobs(JobID int primary key,
CompanyID int,
JobTitle varchar(255),
JobDescription text,
JobLocation varchar(255),
Salary decimal(10,2),
JobType varchar(255),
PostedDate datetime,
foreign key (CompanyID) references Companies(CompanyID));

create table if not exists Applicants(ApplicantID int primary key,
FirstName varchar(255),
LastName varchar(255),
Email varchar(255),
Phone varchar(255),
Resume text);

create table if not exists Applications(ApplicationID int primary key,
JobID int,
ApplicantID int,
ApplicationDate datetime,
CoverLetter text,
foreign key (JobID) references Jobs(JobID),
foreign key (ApplicantID) references Applicants(ApplicantID));


insert into Companies(CompanyID,CompanyName,Location) values 
(1,'Hexaware','Chennai'),
(2,'Wipro','Bangalore'),
(3,'TCS','Hyderabad'),
(4,'Cognizant','Cochin'),
(5,'Hexaware','Noida');

update Companies set Location = 'Chennai' where CompanyID =4;

insert into Jobs(JobID,CompanyID,JobTitle,JobDescription,JobLocation,Salary,JobType,PostedDate) values
(101,1,'Software Developer', 'Develop software applications','Chennai',400000,'Full-Time','2024-03-01 10:30:00'),
(102,2,'Database Administrator', 'Manage databases and ensure data integrity','Coimbatore',120000,'Part-Time','2024-02-12 09:00:00'),
(103,3,'Network Engineer', 'Design and implement network solutions','Bangalore',300000,'Full-Time','2024-03-19 06:35:05'),
(104,4,'Software Developer','Develop software applications','Kolkata',500000,'Full-Time','2024-01-08 11:30:02'),
(105,5,'Network Engineer', 'Design and implement network solutions','Hyderabad',600000,'Part-Time','2024-02-05 08:04:00');

update Jobs set CompanyID = 2 where JobID=103;

insert into Applicants(ApplicantID,FirstName,LastName,Email,Phone,Resume) values
(111,'Raju','Dharma','raju@gmail.com','789-123-4567','Raju Resume'),
(222,'Sara','Stalin','sara@gmail.com','876-234-0987','Sara Resume'),
(333,'Tipu','Kevin','tipu@gmail.com','675-098-2367','Tipu Resume'),
(444,'David','Xavior','david@gmail.com','546-876-1234','David Resume'),
(555,'Anudeep','Kumar','anudeep@gmail.com','123-345-4567','Anudeep Resume');

insert into Applications(ApplicationID,JobID,ApplicantID,ApplicationDate,CoverLetter) values
(11,101,111,'2024-03-12 07:30:00','Cover Letter for Software Developer position'),
(22,102,222,'2024-02-12 08:09:00','Cover Letter for Database Administrator position'),
(33,103,333,'2024-03-10 10:10:10','Cover Letter for Software Developer position'),
(44,104,444,'2024-02-11 03:30:09','Cover Letter for Database Administrator position'),
(55,105,555,'2024-01-10 06:07:00','Cover Letter for Network Engineer position');

update Applications set JobID=102 where ApplicationID =33;


-- QUESTION 5
select j.jobtitle,count(a.applicationid) as applicationcount
from jobs j left join applications a on j.jobid = a.jobid group by j.jobtitle;

-- QUESTION 6
select j.jobtitle,c.companyname,j.joblocation,j.salary
from jobs j join companies c on j.companyid = c.companyid
where j.salary between 150000 and 450000;

-- QUESTION 7
set @ApplicantID = 444;

select j.jobtitle,c.companyname,a.applicationdate
from applications a join jobs j on a.jobid = j.jobid
join companies c on j.companyid = c.companyid
where a.applicantid = @ApplicantID;

-- QUESTION 8

select avg(j.salary) as average_salary from jobs j where j.salary > 0;

-- QUESTION 9
select c.companyname,count(j.jobid) as job_count from companies c
join jobs j on c.companyid = j.companyid group by c.companyid, c.companyname
order by job_count desc limit 1;

-- QUESTION 10

alter table applicants add column experience int;

update applicants set experience = 3 where applicantid = 111;

update applicants set experience = 5 where applicantid = 222;

update applicants set experience = 2 where applicantid = 333;

update applicants set experience = 4 where applicantid = 444;

update applicants set experience = 6 where applicantid = 555;

select * from Applicants;

select distinct a.applicantid,a.firstname,a.lastname from applicants a
join applications app on a.applicantid = app.applicantid
join jobs j on app.jobid = j.jobid
join companies c on j.companyid = c.companyid
where c.location = 'Chennai' and a.experience >= 3;

-- QUESTION 11

update Jobs set Salary=65000 where JobID =104;

update Jobs set Salary=75000 where JobID =102;

select distinct (j.jobtitle) as job_title from jobs j where j.salary between 60000 and 80000;

-- QUESTION 12

select j.jobtitle as job_title, c.companyname,j.joblocation,j.salary from jobs j
join companies c on j.companyid = c.companyid
where j.jobid not in (select distinct jobid from applications);

-- QUESTION 13

select a.firstname as first_name,a.lastname as last_name,c.companyname,j.jobtitle as job_title from applicants a
join applications app on a.applicantid = app.applicantid
join jobs j on app.jobid = j.jobid
join companies c on j.companyid = c.companyid;

-- QUESTION 14

select c.companyname as company_name,count(j.jobid) as job_count from companies c
left join jobs j on c.companyid = j.companyid group by c.companyid, c.companyname;

-- QUESTION 15

select a.firstname as first_name, a.lastname as last_name,
coalesce((c.companyname), 'not applied') as company_name,
coalesce((j.jobtitle), 'not applied') as job_title
from applicants a left join applications app on a.applicantid = app.applicantid
left join jobs j on app.jobid = j.jobid
left join companies c on j.companyid = c.companyid;

-- QUESTION 16

select distinct lower(c.companyname) as company_name from companies c
join jobs j on c.companyid = j.companyid
where j.salary > (select avg(salary) from jobs);

-- QUESTION 17

alter table applicants add column city varchar(255);

alter table applicants add column state varchar(255);

update applicants set city = 'Chennai' where applicantid = 111;

update applicants set city = 'Kolkata' where applicantid = 222;

update applicants set city = 'Coimbatore' where applicantid = 333;

update applicants set city = 'Bangalore' where applicantid = 444;

update applicants set city = 'Chennai' where applicantid = 555;

update applicants set state = 'TamilNadu' where applicantid = 111;

update applicants set state = 'WestBengal' where applicantid = 222;

update applicants set state = 'TamilNadu' where applicantid = 333;

update applicants set state = 'Karnataka' where applicantid = 444;

update applicants set state = 'TamilNadu' where applicantid = 555;

select a.firstname as first_name, a.lastname as last_name,
concat((a.city), ', ', (a.state)) as city_state from applicants a;

-- QUESTION 18

select distinct jobtitle as job_title from jobs where jobtitle like '%developer%' or jobtitle like '%engineer%';


-- QUESTION 19

select a.firstname as first_name, a.lastname as last_name,
coalesce((j.jobtitle), 'not applied') as job_title,
coalesce((c.companyname), 'not applied') as company_name
from applicants a
left join applications app on a.applicantid = app.applicantid
left join jobs j on app.jobid = j.jobid
left join companies c on j.companyid = c.companyid;

-- QUESTION 20

select a.firstname as first_name,a.lastname as last_name,
coalesce((c.companyname), 'not applied') as company_name,
coalesce((c.location), 'not applied') as company_city,a.experience from applicants a
left join applications app on a.applicantid = app.applicantid
left join jobs j on app.jobid = j.jobid
left join companies c on j.companyid = c.companyid
where c.location = 'Chennai' and a.experience > 2;













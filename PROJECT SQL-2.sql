-- Once a student is passed out from a Institute or College, he/she is known as Alumni of the Institute. Alumni’s career growth plays
-- important role in Institute’s ranking and other networking activities. In this project, career choices of alumni of two Universities
-- will be analyzed with respect to their passing year as well as the course they completed.

-- Dataset: Six .csv file (Alumni record of College A and College B) Higher Studies, Self Employed and Service/Job record 
	
	-- College_A_HS ~ Higher Studies Record of College A
	-- College_A_SE ~ Self Employed Record of College A
	-- College_A_SJ ~ Service/Job Record of College A
	-- College_B_HS ~ Higher Studies Record of College B
	-- College_B_SE ~ Higher Studies Record of College B
	-- College_B_SJ ~ Higher Studies Record of College B

-- 1.Create new schema as alumni.
create database alumni;
use alumni;


-- 2.Import all .csv files into MySQL.

select * from college_a_hs;
select * from college_a_se;
select * from college_a_sj;
select * from college_b_hs;
select * from college_b_se;
select * from college_b_sj;

-- 3.Run SQL command to see the structure of six tables.

desc college_a_hs;
desc college_a_se;
desc college_a_sj;
desc college_b_hs;
desc college_b_se;
desc college_b_sj;

-- 4.Display first 1000 rows of tables(College_A_HS, College_A_SE,College_A_SJ, College_B_HS, College_B_SE, College_B_SJ)with Python.
	## Finished in Python.
    
-- 5.Import first 1500 rows of tables(College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ)into MS Excel.
	## Finished in Excel.

-- 6.Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 

create or replace view  college_a_hs_v as select * from college_a_hs where rollno is not null and lastupdate is not null and
name is not null and FatherName is not null and MotherName is not null and batch is not null and degree is not null and
presentstatus is not null and hsdegree is not null and EntranceExam is not null and Institute is not null and location is not null;

-- 7.Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.

create or replace view  college_a_se_v as select * from college_a_se where rollno is not null and lastupdate is not null and
name is not null and FatherName is not null and MotherName is not null and batch is not null and degree is not null and
presentstatus is not null and Organization is not null and location is not null;

-- 8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.

create or replace view  college_a_sj_v as select * from college_a_sj where rollno is not null and lastupdate is not null and
name is not null and FatherName is not null and MotherName is not null and batch is not null and degree is not null and
presentstatus is not null and Organization is not null and designation is not null and location is not null;

-- 9.Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.

create or replace view  college_b_hs_v as select * from college_b_hs where rollno is not null and lastupdate is not null and
name is not null and FatherName is not null and MotherName is not null and branch is not null and batch is not null and 
degree is not null and presentstatus is not null and HSDegree is not null and EntranceExam is not null and institute is not null 
and location is not null;

-- 10.Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.

create or replace view  college_b_se_v as select * from college_b_se where rollno is not null and lastupdate is not null and
name is not null and FatherName is not null and MotherName is not null and branch is not null and batch is not null and
degree is not null and presentstatus is not null and Organization is not null and location is not null;

-- 11.Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.

desc college_b_sj;

create or replace view college_b_sj_v as select * from college_b_sj where rollno is not null and lastupdate is not null and
name is not null and FatherName is not null and MotherName is not null and branch is not null and batch is not null and
degree is not null and presentstatus is not null and Organization is not null and designation is not null and location is not null;

-- 12.Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views. 
-- (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V).

select lower(name),lower(fathername),lower(mothername) from college_a_hs_v;
call lowercase_a_hs();

select lower(name),lower(fathername),lower(mothername) from college_a_se_v;
call lowercase_a_se;

select lower(name),lower(fathername),lower(mothername) from college_a_sj_v;
call lowercase_a_sj;

select lower(name),lower(fathername),lower(mothername) from college_b_hs_v;
call lowercase_b_hs;

select lower(name),lower(fathername),lower(mothername) from college_b_se_v;
call lowercase_b_se;

select lower(name),lower(fathername),lower(mothername) from college_b_sj_v;
call lowercase_b_sj;

-- 13.Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
-- into MS Excel and make pivot chart for location of Alumni.
	## Finished in Excel.

-- 14.Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
set @name='';
call get_name_collegeA(@name);
select @name collegeA_names;

-- 15.Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
set @name='';
call get_name_collegeB(@name);
select @name collegeB_names;

-- 16.Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.

SELECT 'Higher Studies',(SELECT COUNT(*) FROM college_a_hs)/((SELECT COUNT(*) FROM college_a_hs)+
(SELECT COUNT(*) FROM college_a_se)+(SELECT COUNT(*) FROM college_a_sj))*100 'College A Percentage',
(SELECT COUNT(*) FROM college_b_hs)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+
(select count(*)FROM college_b_sj))*100 'College B Percentage'  UNION 
SELECT 'Self Employed',(SELECT COUNT(*) FROM college_a_se)/((select count(*) from college_a_hs)+(select count(*)from college_a_se)+
(SELECT COUNT(*) FROM college_a_sj))*100,(SELECT COUNT(*) FROM college_b_se)/((SELECT COUNT(*) FROM college_b_hs)+
(SELECT COUNT(*) FROM college_b_se)+(select count(*)FROM college_b_sj))*100  UNION
SELECT 'Service Job',(SELECT COUNT(*) FROM college_a_sj)/((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+
(SELECT COUNT(*) FROM college_a_sj))*100,(SELECT COUNT(*) FROM college_b_sj)/((SELECT COUNT(*) FROM college_b_hs)+
(SELECT COUNT(*) FROM college_b_se)+(select count(*)FROM college_b_sj))*100;








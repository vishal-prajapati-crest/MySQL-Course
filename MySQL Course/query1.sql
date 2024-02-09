-- select 1+1;
-- show databases;
-- use pet_shop;

-- desc cats;

-- INSERT INTO cats (name, age) 
-- VALUES ('Jenkins', 7);


---------------------------------------------------------
-- Exersice create table people and insert data into it
---------------------------------------------------------

-- CREATE TABLE IF NOT EXISTS people(
-- first_name varchar(20),
-- last_name varchar(20),
-- age INT);

-- INSERT INTO people 
-- (first_name, last_name, age)
-- VALUES ("Tina", "belchar", 13);

-- INSERT INTO people 
-- (first_name, last_name, age)
-- VALUES ("Bob", "belchar", 42);

-- INSERT INTO people 
-- (first_name, last_name, age)
-- VALUES ("Linda", "belchar", 45),
-- ("Phillip", "Frond", 38),
-- ("Calavin", "Fischoedr", 70);

-- select * from people;

--------------------------------------------------------------
-- use world;
-- select * from country limit 10;

-- select * FROM city INNER JOIN country where city.CountryCode = country.code AND city.District IN ('–') limit 10;

-- CREATE DATABASE practise;

-- use practise;

-----------------------------------------------------------------
-- Exersise insert data into employee table
-----------------------------------------------------------------

-- use practise;

-- CREATE TABLE IF NOT EXISTS Employees (
-- id INT AUTO_INCREMENT NOT NULL primary key,
-- last_name varchar(50) NOT NULL,
-- first_name varchar(50) NOT NULL,
-- middle_name varchar(50) NOT NULL,
-- age INT NOT NULL,
-- current_status  varchar(50) NOT NULL default 'employed'
-- );

-- desc Employees;

-- -- INSERTING DATA

-- INSERT INTO `practise`.`employees`
-- (
-- `last_name`,
-- `first_name`,
-- `middle_name`,
-- `age`)
-- VALUES
-- (
-- 'thomas',
-- 'chikenman',
-- '',
-- 18);

-- INSERT INTO employees(first_name, last_name, age) VALUES
-- ('Dora', 'Smith', 58);

-- SELECT * FROM employees;

-- END ----------------------------------------------------------


----------------------------------------------------------------
-- CRUD CHALLENGES
----------------------------------------------------------------

-- CREATE DATABASE IF NOT EXISTS shirts_db;

-- use shirts_db;

-- CREATE TABLE shirts (
-- shirt_id int auto_increment primary key,
-- article varchar(100) not null,
-- shirt_size char(5) not null,
-- last_worn int not null
-- );

-- ALTER TABLE shirts
-- ADD COLUMN color varchar(100) not null;

-- desc shirts;

-- INSERT INTO shirts(article, color, shirt_size, last_worn) values
-- ('t-shirt', 'white', 'S', 10),
-- ('t-shirt', 'green', 'S', 200),
-- ('polo shirt', 'black', 'M', 10),
-- ('tank top', 'blue', 'S', 50),
-- ('t-shirt', 'pink', 'S', 0),
-- ('polo shirt', 'red', 'M', 5),
-- ('tank top', 'white', 'S', 200),
-- ('tank top', 'blue', 'M', 15);

-- select shirt_id from shirts where shirt_size = 'M';

-- INSERT INTO shirts(article, color, shirt_size, last_worn) values
-- ('polo shirt', 'Purple', 'M', 50);

-- select * from shirts where article = 'polo shirt';

-- UPDATE shirts set shirt_size = 'L'
-- WHERE article = 'polo shirt';

-- UPDATE shirts set last_worn = 0
-- WHERE last_worn >= 15;

-- UPDATE shirts set shirt_size = 'XS', color = 'off white'
-- WHERE color = 'white';

-- select * from shirts;

-- DELETE from shirts where article = 'tank top';
-- DELETE  from shirts;

-- DROP table shirts;

-- -----------------------END-----------------------------------


-----------------------------------------------------------------
-- BOOK DATASET 
-----------------------------------------------------------------
desc books;

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

select * from books;

select DISTINCT author_lname from books;

-- To select books with '%' in their title:
SELECT * FROM books
WHERE title LIKE '%\%%';
 
-- To select books with an underscore '_' in title:
SELECT * FROM books
WHERE title LIKE '%\_%';

-- Title that contsins stories
select title from books where title like '%stories%';

-- Logest book print title and pages
select title, pages from books order by pages desc limit 1;

-- Print summary of most 3 recent books
select concat_ws(' - ', title, released_year) as summary from books order by released_year desc limit 3;

-- find all book that contain space in author last name
select title, author_lname from books where author_lname like '% %';

-- Find 3 books with lowest stock quantity
select title,released_year,stock_quantity from books order by stock_quantity,released_year DESC  limit 3;

-- Print title and author_lname sorted first by author_lname then by title
select title, author_lname from books order by author_lname, title;

-- sorted alphabetically by last name
select upper(concat('my favourite author is ', author_fname, ' ', author_lname, '!')) as yell from books order by author_lname;


-------------------
-- Count 
-------------------
SELECT COUNT(*) FROM books;
 
SELECT COUNT(author_lname) FROM books;
 
SELECT COUNT(DISTINCT author_lname) FROM books;


-------------------
-- GROUP BY 
-------------------
SELECT author_lname, COUNT(*) 
FROM books
GROUP BY author_lname;
 
SELECT 
    author_lname, COUNT(*) AS books_written
FROM
    books
GROUP BY author_lname
ORDER BY books_written DESC;

SELECT author_lname, MIN(released_year) FROM books GROUP BY author_lname;
 
SELECT author_lname, MAX(released_year), MIN(released_year) FROM books GROUP BY author_lname;
 
SELECT 
	author_lname, 
	COUNT(*) as books_written, 
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release,
      MAX(pages) AS longest_page_count
FROM books GROUP BY author_lname;
 
 
SELECT 
	author_lname, 
        author_fname,
	COUNT(*) as books_written, 
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release
FROM books GROUP BY author_lname, author_fname;


--------------------
-- SUB QUERY
--------------------
SELECT title, pages FROM books
WHERE pages = (SELECT MAX(pages) FROM books);
 
SELECT MIN(released_year) FROM books;
 
SELECT title, released_year FROM books 
WHERE released_year = (SELECT MIN(released_year) FROM books);


-----------------------
-- EXERCISE
-----------------------
-- Print number of book in the data base
select count(*) as Total_book from books;

-- Print out how many book released in each year
select released_year, count(*) as total from books GROUP BY released_year;

-- Total number of book in stock
select sum(stock_quantity) from books;

-- avg realeased year for each author
select concat(author_fname,' ', author_lname) as full_name, avg(released_year) as AVG from books GROUP BY author_fname, author_lname;

-- Full name of the author who wrote longest book
select concat(author_fname,' ', author_lname) as full_name from books
WHERE pages = (select max(pages) from books);

-- print number of books and avg pages released in each year
select released_year, count(*) as '# books', avg(pages) as 'avg pages' from books GROUP BY released_year order by released_year;

-- <= operator
SELECT * FROM books
WHERE pages < 200;
 
SELECT * FROM books
WHERE released_year < 2000;
 
SELECT * FROM books
WHERE released_year <= 1985;

-- AND operator
SELECT title, pages FROM books 
WHERE CHAR_LENGTH(title) > 30
AND pages > 500;
 
SELECT title, author_lname FROM books
WHERE author_lname='Eggers' AND
released_year > 2010;
 
 -- OR operator
SELECT title, author_lname, released_year FROM books
WHERE author_lname='Eggers' OR
released_year > 2010;
 
SELECT title, pages FROM books
WHERE pages < 200 
OR title LIKE '%stories%';

-- BETWEEEN 
SELECT title, released_year FROM books
WHERE released_year <= 2015
AND released_year >= 2004;
 
SELECT title, released_year FROM books
WHERE released_year BETWEEN 2004 AND 2014;

-- CASE 
SELECT title, released_year,
       CASE 
         WHEN released_year >= 2000 THEN 'Modern Lit'
         ELSE '20th Century Lit'
       END AS GENRE
FROM books;

SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
        WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
        WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
        WHEN stock_quantity BETWEEN 101 AND 140 THEN '****'
        ELSE '*****'
    END AS stock
FROM
    books;

------------------------
-- EXERCISE
------------------------
-- Select All Books Written Before 1980
select title from books where released_year < 1980;

-- Select All Books Written By Eggers Or Chabon
select title from books where author_lname in ('Eggers','Chabon');

-- Select All Books Written By Lahiri, Published after 2000
SELECT title from books WHERE author_lname = 'Lahiri' AND released_year > 2000;

-- Select All books with page counts between 100 and 200
select title, pages from books where pages between 100 AND 200;

-- Select all books where author_lname  starts with a 'C' or an 'S''
select title, author_lname from books where author_lname like 'C%' OR author_lname LIKE 'S%';
SELECT title, author_lname
FROM books WHERE SUBSTR(author_lname, 1, 1) in ('C', 'S');

-- If title contains 'stories'   -> Short Stories, Just Kids and A Heartbreaking Work  -> Memoir,Everything Else -> Novel
SELECT title, author_lname,
	CASE
		WHEN title Like '%stories%' then 'Short Stories'
        WHEN title Like '%Just Kids%' OR  title Like '%A Heartbreaking Work%' then 'Memoir'
        ELSE 'Novel'
    END AS TYPE
 from books;
 
 SELECT author_fname, author_lname,
	CASE
		WHEN count(title) > 1 then concat(count(title),' books')
        ELSE '1 book'
    END AS Count
 from books
 WHERE author_lname IS NOT NULL
 GROUP BY author_fname, author_lname;


-- -----------------------END------------------------------------


-----------------------------------------------------------------
-- DATE AND TIME
-----------------------------------------------------------------
SELECT CURTIME();
 
SELECT CURDATE();
 
SELECT NOW();

-- What's a good use case for CHAR?
 
-- Used for text that we know has a fixed length, e.g., State abbreviations, 
-- abbreviated company names, etc.
 
CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8,2),
    quantity INT
);
 
-- What's the difference between DATETIME and TIMESTAMP?
 
-- They both store datetime information, but there's a difference in the range, 
-- TIMESTAMP has a smaller range. TIMESTAMP also takes up less space. 
-- TIMESTAMP is used for things like meta-data about when something is created
-- or updated.
 
 
SELECT CURTIME();
 
SELECT CURDATE();
 
SELECT DAYOFWEEK(CURDATE());
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1;
 
SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');
 
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
 
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');
 
CREATE TABLE tweets(
    content VARCHAR(140),
    username VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);
 
INSERT INTO tweets (content, username) VALUES('this is my first tweet', 'coltscat');
SELECT * FROM tweets;
 
INSERT INTO tweets (content, username) VALUES('this is my second tweet', 'coltscat');
SELECT * FROM tweets;inventory

-- -----------------------END------------------------------------


-----------------------------------------------------------------
-- CONSTRAINTS
-----------------------------------------------------------------

-- UNIQUE CONSTRAINT
CREATE TABLE IF NOT EXISTS contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');
-- This insert would result in an error:
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');
DROP TABLE Contacts;

-- CHECK CONSTRAINT
CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);
CREATE TABLE palindromes (
  word VARCHAR(100) CHECK(REVERSE(word) = word)
);
DROP TABLE users;
DROP TABLE palindromes;

-- NAMED CONSTRAINT
CREATE TABLE users2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);
CREATE TABLE palindromes2 (
  word VARCHAR(100),
  CONSTRAINT word_is_palindrome CHECK(REVERSE(word) = word)
);
DROP TABLE users2;
DROP TABLE palindromes2;


-- -----------------------END------------------------------------

use practise;

select distinct num as consecutive_number from (select id,num,
case
 when lag(num) over() = num AND lead(num) over() = num then 'num'
 else ''
end as nums
from logs) as tb
Where nums= 'num';

select id,num,
case
 when lag(num) over() = num AND lead(num) over() = num then 'num'
 when lag(num) over() = null AND lead(num) over() = null then 'lf'
 else ''
end as nums
from logs;

SELECT DISTINCT
    l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;

SELECT DISTINCT
    *
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;

INSERT INTO Logs(id,num) VALUES(10,2);


CREATE TABLE Employee (
id INT PRIMARY KEY,
name varchar(200) NOT NULL,
salary INT NOT NULL,
departmentId INT,
FOREIGN KEY (departmentId) REFERENCES Department(id) 
);

CREATE TABLE Department (
id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

INSERT INTO Department VALUES (1,'IT'),(2,'Sales');

INSERT INTO Employee VALUES 
(1,'Joe',85000,1),
(2,'Henry',80000,2),
(3,'Sam',60000,2),
(4,'Max',90000,1),
(5,'Janet',69000,1),
(6,'Randy',85000,1),
(7,'Will',70000,1);

SELECT Department, Employee, salary FROM (
SELECT Department.name AS Department, Employee.name as Employee , salary, DENSE_Rank() over(PARTITION BY Department.name ORDER BY salary DESC) AS dept_sal_rank
FROM Employee
JOIN Department ON Employee.departmentId = Department.id
) AS rank_table WHERE dept_sal_rank <= 3;


-- get highest Friends
use practise;

CREATE TABLE RequestAccepted  (
    requester_id INTEGER NOT NULL,
    accepter_id INTEGER NOT NULL,
    primary key (requester_id,accepter_id)
);

INSERT INTO RequestAccepted VALUES
(1,2),
(1,3),
(2,3),
(3,4);

select requester_id AS Maximum_Friend
from (select requester_id, accepter_id from RequestAccepted UNION ALL select accepter_id, requester_id from RequestAccepted) as tb
GROUP BY requester_id ORDER BY Count(*) DESC LIMIT 1;
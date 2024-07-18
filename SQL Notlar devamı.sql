--INNER  JOIN
--Birden fazla tablodaki verileri birleştimemizi sağlar.INNER JOIN yapısı simetriktir,örneğin author - book tablolarının yerlerinin değiştirilmesi sonucu etkilemez.
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;

--Book tablosundan author_id ve author tablosundan id sütununu eşleyerek tbalo birleştirmek istersek;
SELECT title, first_name, last_name FROM book
INNER JOIN author ON book.author_id=author.id;
--It is a good practice to include the table name when specifying columns in the SQL statement.
SELECT book.title, author.first_name, author.last_name FROM book
INNER JOIN author ON book.author_id=author.id;

--LEFT JOIN
--Eşleşme tablo 1'deki değerler üzerinde olur yani Tablo 1'deki yani solda kalan tüm değerleri kapsar.
--Buradaki tablo1 "left table", tablo2 "right table" olarak da adlandırılır.
SELECT title,first_name,last_name FROM book
LEFT JOIN author ON author.id=book.author_id;
--Burda Table 1 book tablosudur bu yüzden book tablosundaki her veriyi almış oluruz.Tablo 1 de olup Tablo 2 de olmayan veriler için NULL değeri kullanılır.

--Sonradan bir kısıt kaldırmak için;
ALTER TABLE book
DROP CONSTRAINT book_author_id_fkey;
-- The LEFT JOIN keyword returns all records from the left table (Customers), even if there are no matches in the right table (Orders).

--RIGHT JOIN
--RIGHT JOIN yapısındaki tablo birleştirmesinde, birleştirme işlemi tablo 2 (sağdaki tablo) üzerinden gerçekleştirilir.
SELECT book.title, author.first_name, author.last_name
FROM book
RIGHT JOIN author
ON author.id = book.author_id
--Bu senaryoda Table 2 yani author tablosundaki tüm veriler alınır
SELECT book.title, author.first_name, author.last_name
FROM author
LEFT JOIN book
ON author.id = book.author_id
--Tüm verileri isteyeceğimiz tablo 1. tabloysa left join 2.tabloysa right join kullanılır.

--FULL JOIN
--Birleştirme iki tablo üzerinden gerçekleşir Tablo 1 de olup Tablo 2 de olmayan ve Tablo 2 de olup Tablo 1 de olmayan veriler için NULL değeri kullanılır.
SELECT * FROM author
FULL OUTER JOIN book
ON author.id = book.author_id
WHERE (book.id IS NOT NULL AND author.id IS NOT NULL);

--Tablolardaki ortak olmayan verileri görmek için bu senaryoyu kullanırız;
SELECT * FROM author
FULL OUTER JOIN book
ON author.id = book.author_id
WHERE (book.id IS NULL OR author.id IS NULL);
--FULL OUTER JOIN and FULL JOIN are the same

--UNION
--SELECT ile, elde ettiğimiz birden fazla sorguyu birleştirir tek bir sonuç kümesi haline getiririz.
--bookstore veritabanında iki adet sorgu yapıyoruz. İlk sorgumuzda sayfa sayısı en fazla olan 5 kitabı, ikinci sorgumuzda ise isme göre 5 kitabı sıralıyoruz.
--UNION anahtar kelimesi sayesinde bu iki sorguyu da birleştirebiliriz.
--Sütun sayıları aynı olması yanında bu sütunlardaki veri tiplerinin de aynı olması gerekmektedir.
--UNION: Only distinct values (benzersiz verileri girer)  UNION ALL: duplicates values also(aynı verileri de alır)

--Örneğin kitap ismine göre sıralama ve sayfa sayısı çoktan aza doğru sorgularının birleşimi;
( SELECT * FROM book
ORDER BY title
LIMIT 5
)
UNION
(
SELECT * FROM book
ORDER BY page_number DESC
LIMIT 5
);

--INTERSECT
--İki sorgunun kesişimini almak için kullanılır.
( SELECT * FROM book
ORDER BY title
LIMIT 5
)
INTERSECT
(
SELECT * FROM book
ORDER BY page_number DESC
LIMIT 5
);

--EXCEPT
--Yukarıdaki ilk sorguda bulunan ancak 2. sorguda bulunmayan verileri gösterir.

---birden fazla SELECT sorgusunu aynı tabloda birleştirmek istersek: UNION

---kesişim :INTERSECT
--INTERSECT operatörü kullanılacağı sorguların, sütun sayıları eşit olmalıdır ve sütunlardaki veri tipleri eşleşmelidir.
--INTERSECT operatörü bize kesişen veriler içerisindeki tekrar edenleri göstermez. Tekrar edenleri görmek için INTERSECT ALL kullanırız.
---ilk sorguda olan ancak 2. sorguda olmayan değerleri görmek istersek EXCEPT

--HACKERRANK ÖRNEKLER--
--Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name.
SELECT NAME FROM STUDENTS 
WHERE MARKS > 75
ORDER BY RIGHT(NAME, 3) ASC, ID ASC
--Son 3 harfe göre sıralamak için RIGHT (NAME,3) kullanırız.

--Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month
--who have been employees for less than  months. Sort your result by ascending employee_id.
SELECT name FROM employee
WHERE salary > 2000 AND months <10
ORDER BY employee_id ASC

--Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT (city) FROM STATION
WHERE NOT LEFT(CITY,1) IN ('a','e','i','o','u');

--Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates
SELECT DISTINCT (CITY) FROM STATION
WHERE NOT RIGHT (CITY,1)  IN ('a','e','i','o','u');

--Sondan üç harfi,ilk harfi son harfi vb istenen sorgularda SUBSTR(string, start, length) kullanılabilir..

Note: The position of the first character in the string is 1.

1	2	3	4	5	6	7	8	9	10  11  12
S	Q	L	 	T	u	t	o	r i 	a	 l
Note: The position of the last character in the string is -1.

-12	-11	-10	-9	-8	-7	-6	-5	-4	-3	-2	-1
 S	 Q  	  L	 	 T	  u	 t	 o	 r	 i  	 a	 l

--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT(CITY) FROM STATION
WHERE SUBSTRING(CITY,-1,1) IN ('a','e','i','o','u')

--Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT(CITY) FROM STATION
WHERE SUBSTRING(CITY,-1,1) IN ('a','e','i','o','u') AND SUBSTRING(CITY,1,1) IN ('a','e','i','o','u') ;

--LENGTH
--The LENGTH() function returns the length of a string (in bytes)


 -- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

 --Alt Sorgular (SUBQUERIES)
--Statik bir değer yerine herhangi bir sorgu sonucunda elde ettiğimiz değeri bir başka sorgunun koşuluna yazarak alt sorgu oluşturabiliriz.
--Önce parantez içindeki sorgu çalışır.
--İlk 238'den büyük sayfa sayısına sahip kitapları sıralıyoruz.
SELECT * FROM book
WHERE page_number > 238;

--Bu sorguda elde ettiğimiz ve sınır olarak seçtiğimiz sayıya ait kitabın ismini başka bir sorguda alt sorgu olarak  kullanabiliriz.(7 çıktı olmalı)
SELECT * FROM book
WHERE page_number > 
(
	SELECT page_number FROM book
	WHERE title= 'Cutie Honey'
);

SELECT title,page_number,(SELECT MAX(page_number)FROM book) FROM book
WHERE page_number >
(
	 SELECT page_number FROM book 
		WHERE title = 'Cutie Honey'
);

--max sütununu sorguladığımız değerlerin ayrı ayrı farkını da almak istersek;
SELECT title,page_number,(SELECT MAX(page_number)FROM book),((SELECT MAX(page_number)FROM book)- page_number) AS differ FROM book
WHERE page_number >
(
	SELECT page_number FROM book 
	WHERE title = 'Cutie Honey'
);

--ANY ve ALL
--ANY:The ANY operator returns true if the comparison returns true for at least one of the values in the set, and false otherwise.
--Alt sorgumuzda birden fazla koşul varsa koşullardan herhangi biri doğru olursa ANY o değerleri gösterir.Ancak ALL operatöründe sonuç alabilmek için tüm koşulların doğru olması gerekir
--returns TRUE if ALL of the subquery values meet the conditio
SELECT first_name, last_name FROM author
WHERE id= ANY 
(
	SELECT id FROM book
	WHERE title= 'Cutie Honey' OR title= 'Father Sergius'
);

--id 40 ya da 41'den büyük değerleri (yani 41'den büyük değerleri ) göstermesi için; 
SELECT first_name, last_name FROM author
WHERE id > ANY
(
	SELECT id FROM book
	WHERE title= 'Cutie Honey' OR title= 'Baby on Board'
);

--author'da id'si 42'den fazla değerleri sıralar (eğer iki koşul da doğruysa)
SELECT first_name, last_name FROM author
WHERE id > ALL
(
	SELECT id FROM book
	WHERE title= 'Making Plans for Lena' OR title= 'Baby on Board'
);

--İlk ve son harfi sesli harflerle başlamayan şehirler için;
SELECT DISTINCT city FROM station
WHERE
        SUBSTRING (city,1,1) NOT IN ('a','e','o','i','u')
        OR
        SUBSTRING (city,-1) NOT IN ('a','e','o','i','u');

--JOIN VE SUBQUERIES

--bookstore veri tabanında kitap sayfası sayısı ortalama kitap sayfası sayısından
--fazla olan kitapların isimlerini, bu kitapların yazarlarına ait isim ve soyisim bilgileriyle birlikte sıralayınız.
SELECT author.first_name, author.last_name,page_number FROM author 
INNER JOIN book ON author.id=book.author_id
WHERE page_number >
(
	SELECT AVG(page_number) FROM book
);

--dvdrental veritabanında en uzun filmlerin isimlerini aktör isim ve soyisimleriyle birlikte sıralayalım
SELECT actor.first_name, actor.last_name,film.title, film.length FROM actor
INNER JOIN film_actor ON film_actor.actor_id=actor.actor_id 
INNER JOIN film ON film.film_id=film_actor.film_id
WHERE length= 
(
	SELECT MAX (length) FROM film
);

--Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective 
--average city populations (CITY.Population) rounded down to the nearest integer.
SELECT COUNTRY.Continent, FLOOR( AVG(CITY.Population)) AS "AVERAGE POPULATION" FROM CITY
INNER JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent
ORDER BY "AVERAGE POPULATION";



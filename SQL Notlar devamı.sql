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





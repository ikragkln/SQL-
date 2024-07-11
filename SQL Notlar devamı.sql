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

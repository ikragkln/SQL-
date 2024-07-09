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




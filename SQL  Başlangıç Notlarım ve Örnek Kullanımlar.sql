--SELECT--
--SELECT column1 FROM table1,ilk başa istenen sütun başlığı yazılır nereden alınacağı ise FROM dan sonra belirtilir.
--SQL komutları case insensitive değildir yani büyük küçük harfle de çalısır
-- ; birden fazla sorguyu ayırmamızı sağlar
--SELECT: veri almak veri sıralamak için kullanılır
--SQL deklaratif yani beyan edici dildir.Önemli olan sonucları almaktır.
--SELECT title,description FROM film;
SELECT first_name,last_name FROM actor;
--Execute/Refresh için F5--

--WHERE--
--Where anahtar kelimesi koşulu ifade eder.Genelde koşulların bir alta yazılması kodu daha okunur kılar.
SELECT * FROM film WHERE replacement_cost = 14.99 ;
--Bu bölümde comparison tables bak
--WHERE length > 90 (90dan büyük) WHERE rental_rate !=0.99 (eşit olmayan)
--WHERE rental_duration <> 6 (eşit değil)
SELECT * FROM film
WHERE length >= 100 
 
--Logical Operators
--https://www.postgresql.org/docs/13/functions-logical.html
--https://www.tutorialspoint.com/sql/sql-operators.htm
--https://www.w3schools.com/sql/sql_operators.asp

--AND
-- AND operatörü mantıksaldır. 2. bir koşul oluşturmak için WHEREden sonra yazılır
--AND:operatöründen çıktı almak için 2 koşul da karşılanmalıdır.
--AND:Evaluates to true only if all conditions are met

--OR--
--OR:İlk ya da 2. koşulda herhangi bir koşul karşılanıyorsa çıktı alınır.Evaluates to true only if either of the conditions is met.
--WHERE first_name = 'Penelope' AND last_name = 'Monroe' 
 
SELECT * FROM actor
WHERE first_name = 'Penelope' OR first_name = 'Bob' ;

 --AND & OR
--SELECT * FROM film
--WHERE rental_rate <> 4.99 AND length >=90
--WHERE rental_rate =2.99 OR rental_rate=0.99
--WHERE rental_rate = 4.99 AND rental_duration =4 AND replacement_cost > 20 
--WHERE rental_rate != 4.99 eşit olmayan

--NOT--
--NOT clause o koşulları taşımayan çıktılar için kullanılır örneğin;
--WHERE NOT (rental_rate = 4.99 AND replacement_cost =20.99) WHERE den hemen sonra NOT yazılır ve koşulu içeren ifadeler paranteze alınır
--NOT kullanırken eğer AND kullanılıyorsa iki koşulun ikisini de sağlamayan veriler getirilir.
--WHERE NOT (NOT (rental_rate = 4.99 AND replacement_cost =20.99;)) Bu ifade ise tam tersi.

SELECT * FROM film
WHERE NOT (NOT (rental_rate = 4.99 AND replacement_cost =20.99))

--BETWEEN
--90,120 arasındaki değerler için böyle de sorgu oluşturabiliriz fakat BETWEEN operatörü daha kolaylık sağlar.
--SELECT * FROM film
--WHERE length => 90 AND length <= 120
--BETWEEN (arasındaki değerler)
 
SELECT title,length FROM film
WHERE length BETWEEN 90 AND 120 
 
-- Between kullanırken yazdığımız sınır değerleri sonuca dahildir
--Dolayısıyla " WHERE length => 90 AND length <= 120 " ve "WHERE length BETWEEN 90 AND 120" ifadesi aynı sonucu verir.
 
SELECT title,length FROM film
WHERE length NOT (BETWEEN 90 AND 120) 
 
--90 ve 120 dahil arasındaki değerleri içermeyen sonucu verir.
-- "WHERE length NOT (BETWEEN 90 AND 120)" ifadesi ile "WHERE length < 90 OR length > 120" ifadesi aynıdır.

SELECT * FROM film
WHERE (rental_rate BETWEEN 2 AND 4) AND (replacement_cost BETWEEN 10 AND 20);

--IN
--OR değeri benzer işlevde kullanılır fakat çoklu değerler için IN clause pratiklik sağlar .The IN operator is a shorthand for multiple OR conditions.
--Uzunluğu yalnızca 40,50,60 olan değerler için IN kullanırız.

SELECT * FROM film
WHERE length IN (40,50,60)
 
--"WHERE length IN (40,50,60)" ile " WHERE length=40 OR length=50 OR length=60 " ifadesi aynıdır.
 
SELECT * FROM film
WHERE replacement_cost IN (10.99,12.99,20.99);

SELECT * FROM film
WHERE replacement_cost NOT IN (10.99,12.99,20.99);


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


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
--OR değeri benzer işlevde kullanılır fakat çoklu değerler için IN clause pratiklik sağlar.The IN operator is a shorthand for multiple OR conditions.
--Uzunluğu yalnızca 40,50,60 olan değerler için IN kullanırız.

SELECT * FROM film
WHERE length IN (40,50,60)
 
--"WHERE length IN (40,50,60)" ile " WHERE length=40 OR length=50 OR length=60 " ifadesi aynıdır.
 
SELECT * FROM film
WHERE replacement_cost IN (10.99,12.99,20.99);

SELECT * FROM film
WHERE replacement_cost NOT IN (10.99,12.99,20.99);

LIKE 
--Filtreleyeceğimiz veriye benzerlerini filtrelemek için kullanırız
--Baş harfi M ile başlayan veriler için
SELECT * FROM customer
WHERE first_name LIKE 'M%'
-- % = % işareti yerinde ya herhangi bir karakter yoktur ya da birden fazla karakter vardır.Bu şekilde yer tutucu işlevi görür.Wildcard olarak isimlendirilir.
--Son harfi y ile bitenler için
SELECT * FROM customer
WHERE first_name LIKE '%y'
--% Bu yer tutucuyu nereye getirirsek
-- aranan kriterde büyük küçük harf önemlidir.
--   ' _ ' tek bir karakter için yer tutucu,wildcard
SELECT * FROM customer
WHERE first_name LIKE 'T_m'
--
~~ LIKE anlamına gelir . 
--Return all customers from a city that contains the letter 'L'
SELECT * FROM Customers
WHERE city LIKE '%L%';
--Return all customers that have "r" in the second position:
SELECT * FROM Customers
WHERE CustomerName LIKE '_r%';

ILIKE 
--case insensitive değildir
~~* ILIKE anlamına gelir.
!~~*  NOT ILIKE 
 
SELECT * FROM customer
WHERE first_name ~~* 'vi%'

--WILDCARDS
--https://www.w3schools.com/sql/sql_wildcards.asp
 
--DISTINCT
-- sütundaki birbirinden farklı değerleri sıralar.
 
SELECT DISTINCT rental_rate FROM film
 --rental rate sütunundaki farklı verileri sıralar

--COUNT
--İstenilen şartı saplayan kaç tane veri olduğununu gösterir
 
SELECT COUNT (*) FROM actor
WHERE first_name = 'Penelope'
--
SELECT COUNT (*) FROM actor
WHERE first_name LIKE 'A%'
 
SELECT COUNT (DISTINCT first_name) FROM actor
--Actor tablosundaki birbirinden farklı değerlerin sayılarını verir.
--COUNT tan sonraki parametre parantez içinde yazılır.
 
SELECT COUNT(DISTINCT length) FROM film
--birbirinden farklı kaç tane uzunluk olduğunu sayar.

--ORDER BY 
--Seçilen verilerin sıralanması için kullanılır. ORDER BY 'dan sonra neye göre sıralanacağı belirtilir.Bu şekilde yapılan sıralama ASC (artan) yani varsayılan şeklindedir,sorgunun belirgin olması için ayrıca yazılabilir.
--Ascending -- ASC - Artan
--Descending -- DSC - Azalan
--Alfabetik olarak sıralamak için (A-Z) = ASC , (Z-A) = DESC
--Verilerin nasıl sıralanacağını belirlemeden önce koşulları belirlemek gerekir.Yani ORDER BY,WHERE'den sonra gelir.
 
SELECT * FROM film
ORDER BY title ASC;

--Rental rate artan, length azalan , ve title A ile başlayan olacak şekilde koşulların gösterilmesini istersek

SELECT title,rental_rate,length FROM film
WHERE title LIKE 'A%'
ORDER BY rental_rate ASC ,length DESC;


--Rating G'ye eşit olanları uzunluğu azalan olacak şekilde sıralamak istersek;

SELECT * FROM film
WHERE rating='G'
ORDER BY length DESC;

-- Rating'in R'ye , rental_duration'ın  9'a eşit olduğu length'in ise azalan şekilde sıralandığı bir tablo için;

SELECT * FROM film
WHERE rating = 'R' AND rental_duration =9
ORDER BY length DESC;

--LIMIT , OFFSET
--Limit clause ile sıralamak istediğmiz verilere bir sınır getiririz.

--length artan şekilde,rental rate 4.99 a eşit ilk 10 veri için;

SELECT * FROM film
WHERE rental_rate= 4.99
ORDER BY length ASC
LIMIT 10;

--Önce koşullamayı, sonra gruplamayı en son ise LIMIT kullanarak istediğimiz veri sayısını görüntüleyebiliriz.







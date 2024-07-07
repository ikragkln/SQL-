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

--LIKE 
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

--ILIKE 
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
--İstenilen şartı sağlayan kaç tane veri olduğununu gösterir.
 
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

--Örneğin STATION tablosunda CITY sayısından, birbirinden farklı CITY sayısının farkını bulmak istersek;
SELECT (COUNT(CITY)-COUNT(DISTINCT CITY)) FROM STATION;

--ORDER BY 
--Seçilen verilerin sıralanması için kullanılır. ORDER BY 'dan sonra neye göre sıralanacağı belirtilir.Bu şekilde yapılan sıralama ASC (artan) yani varsayılan şeklindedir,sorgunun belirgin olması için ayrıca yazılabilir.
--Ascending -- ASC - Artan
--Descending -- DESC - Azalan
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

--LIMIT
--Limit clause ile sıralamak istediğmiz verilere bir sınır getiririz.

--length artan şekilde,rental rate 4.99 a eşit ilk 10 veri için;

SELECT * FROM film
WHERE rental_rate= 4.99
ORDER BY length ASC
LIMIT 10;

--Önce koşullamayı, sonra gruplamayı en son ise LIMIT kullanarak istediğimiz veri sayısını görüntüleyebiliriz.

--Sütun ismini değiştirmek için FROM'dan önce AS clause kullanılır.Eğer sadece 10 veri gözüksün istiyorsak LIMIT ile sınırlarız--
SELECT first_name AS  ad  FROM actor 
LIMIT 10:

--OFFSET 
--Verileri sıralarken belirtiln sayı kadar veri atlanmasını sağlar.Örneğin ,lk 6 veriyi atlayıp sonrasındaki 4 verinin çıktısı için;
SELECT * FROM country
OFFSET 6 
LIMIT 4;
--PostgreSQL evaluates the OFFSET clause before the LIMIT clause. 
--https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-limit/

--AGGREGATE FONKSİYONLAR
--MAX; İlgili sütundaki en büyük değerin çıktısını verir.Örneğin en büyük replacement_cost için;
SELECT MAX (replacement_cost) FROM film;
--MIN; İlgili sütundaki en küçük değerin çıktısını verir.Örneğin en en küçük replacement_cost için;
SELECT MIN (replacement_cost) FROM film;
--AVG;Seçilen sütunun ortalamasını alır.Örneğin ortakam film uzunluğu (length) için;
SELECT AVG (length) FROM film;
--ROUND; Çıktıda virgül sonrası basamakta fazla 0 varsa ve daha az karakter görüntülemek istiyorsak ROUND kullanırız. İlk AVG fonksiyonu sonra görüntülemek istediğimiz karakter sayısını yazarız.
SELECT ROUND (AVG (length),3) FROM film;
--SUM; İlgili sütundaki verileri toplamak için;
SELECT SUM (rental_rate) FROM film;
--Film uzunluğu (length) en çok olan,(length) en az olan ve replacement cost değerlerinin toplamının çıktısını almak için;
SELECT MAX (length), MIN (length), SUM (replacement_cost) FROM film;
--rental_rate 0.99 olan en en uzun (length) film için
SELECT MAX (length) FROM film
WHERE rental_rate= 0.99;
--rental_rate 0.99 ve 2.99 olan en uzun (length) film için;
SELECT MAX (length) FROM film
WHERE rental_rate IN (0.99,2.99);
--AGGREGATE fonksiyonu kullanırken aynı zamanda başka bir sütunu görünteleyemeyiz.

--GROUP BY
--Aynı sonuçları(MIN,MAX,AVG,SUM) veri kümesinin içindeki farklı kategorilerde de görmek istediğimizde kullanırız.2-3 değer için ayrı ayrı SELECT MAX(length) FROM film  WHERE rental_rate = 0.99; sorgusu yazabiliriz fakat 40 veya daha fazla değer için GROUP BY kullanırız.
--SELECT anahtar kelimesinde bulunan sütunların GROUP BY anahtar kelimesi içerisinde bulunması gerekir.
--Birbirinden farklı rental_rate değerlerinin en uzun film süresi için;
SELECT rental_rate, MAX(length) FROM film
GROUP BY rental_rate;
--rentalrate---- max 
--2.99	----------185
--4.99	--------- 185
--0.99 ----------184

--Birbirinden farklı rental_rate değerlerinin sayısı için;
SELECT rental_rate,COUNT(*) FROM film
GROUP BY rental_rate;
--Her bir ratinge göre film sayısı için;
SELECT rating,COUNT(*) FROM film
GROUP BY rating;
--Her bir replacement costa karşılık gelen en kısa film için;
SELECT replacement_cost, MIN(length) FROM film
GROUP BY replacement_cost;
--SELECT kısmına replacement cost yazmadan da sorgu çalışır ama hangi replacement costa hangi değerin denk geldiğini göremeyiz.
--rc artan,rr azalan bir şekilde her bir farklı değere karşılık gelen min film süreleri için;
SELECT replacement_cost,rental_rate, MIN(length) FROM film
GROUP BY replacement_cost,rental_rate
ORDER BY replacement_cost,rental_rate DESC;
--aggregate fonksiyona göre de sıralanabilir.
SELECT replacement_cost,rental_rate, MIN(length) FROM film
GROUP BY replacement_cost,rental_rate
ORDER BY MIN(length); 
--Verileri grupla,sırala,sonra kaç veri gözükeceğini belirt.

--HAVING
--Gruplandırdığımız verilere koşul vermek için kullanılır.Gruplanmış veri üzerinden filtreleme yapar fakat WHERE verileri önce koşullandırır sonra gruplar.
-- film sayısı 325ten fazla olan rental_rate sayısı;
SELECT rental_rate, COUNT(*) FROM film
GROUP BY rental_rate
HAVING COUNT(*) > 325; 
--Staff id sayısı 7300'den fazla;
SELECT staff_id,COUNT(*) FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 7300
--Satış miktarı 100'den fazla müşteri sayısı için(artan olarak sıralanmış);
SELECT customer_id,SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount)>100
ORDER BY SUM(amount) ASC;

--AS
--AS (ALIAS) anahtar kelimesi sayesinde sorgular sonucu oluşturduğumuz sanal tablo ve sütunlara geçici isimler verebiliriz.
--An alias only exists for the duration of that query.
-- first_name sütununu isim olarak last_name sütununu soyisim olarak geçici isimlendirmek için;
SELECT first_name AS "isim" last_name AS "soyisim" FROM actor;
--SELECT first_name isim, last_name soyisim FROM actor; Bu şekilde de yazabiliriz fakat daha anlaşılır olması için AS kullanırız.
--Aggregate fonskiyonla birlikle kullanımı;
SELECT COUNT(*) AS film_sayısı FROM film;

--CONCAT
--Sütun verilerini birleştirmek için kullanılır.
SELECT CONCAT (first_name,' ',last_name ) AS isim_soyisim FROM actor;
--sütun ismini boşluk kullanarak yazmak istiyorsak örneğin SELECT ProductName AS "My Great Products" şeklinde yazarız.
--city verisinin karşısında id ve last updatei birlikte görmek istersek;
SELECT city, CONCAT(country_id,', ',last_update) AS "id ve last update" FROM city;


--CREATE TABLE
--Databases>Create>Database
--Sütunlara verilecek isim, sütunların veri tipi ve varsa sütunlarda bulunan kısıtlama yapıları girilir.
CREATE TABLE <table_name> (
 <column_name> <data_type> <constraints>,
             .....
 <column_name> <data_type> <constraints>;
)

--Author isimli bir tablo oluşturalım;
CREATE TABLE author (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100),
	birthday DATE,
)
--INSERT INTO Tabloya veri girmek için kullanılır.
--VALUES ile girilecek değerleri belirtiriz.
INSERT INTO <table_name> (<column_name1>,<column_name2>,<column_name3>)
VALUES
	(column1value,column2value,column3value)
 --Bu şekilde verileri gireriz
 
INSERT INTO author(first_name, last_name, email, birthday)
VALUES
	('John', 'Stark', 'johnstark@gmail.com', '1980-12-20'),
	('Con', 'Doe', 'condoe@gmail.com', '1992-05-15'),
	('Michael', 'Smith', 'msmith@hotmail.com', '1985-09-03'),
	('Emily', 'Jones', 'emily.jones@outlook.com', '1978-11-11'),
	('Robert', 'Brown', 'rbrown@gmail.com', '1990-07-22'),
	('Sarah', 'Wilson', 'sarahwilson@aol.com', '1983-03-08'),
	('David', 'Taylor', 'david.taylor@gmail.com', '1975-01-29'),
	('Laura', 'Miller', 'laura.miller@yahoo.com', '1988-04-14');

--Yeni tablo oluşturacağımız zaman başka bir tablonun benzerini oluşturmak istiyorsak (sütun ismini kopyalar);
CREATE TABLE author2 (LIKE author)
--Author tablosundaki herhangi bir satırdaki veriyi author2'ye taşırken;
INSERT INTO author2
SELECT * FROM author
WHERE first_name= 'Emily'

--Verilerin tamamını kopyalamak istersek
CREATE TABLE author3 (LIKE author)
 
INSERT INTO author3 
SELECT * FROM author;
--Kısayolu ise;
CREATE TABLE author3 AS
SELECT * FROM author;

--DROP tablo silmek için kullanılır. Hata mesajı almamak için yani olmayan bir tabloyu silmeye çalışırken çıkan hata mesajını almamak için IF EXISTS kullanırız.
DROP TABLE IF EXISTS author4;

--Rastgele veriler elde etmek için,dummy data for sql;Mockaroo https://www.mockaroo.com/
--blank: oluşturacağımız verinin ne kadar boş bırakılacağının yüzdesi
--INSERT INTO ve VALUES formülleriyle tabloya ekle


--UPDATE
--Tablodaki verileri güncelleriz.
UPDATE <tablo_adı>
SET <sütun_adı> = değer, 
    <sütun_adı> = değer,
    ----
WHERE <koşul_adı>;

--Örneğin isim ve soyismi değiştirmek istersek
UPDATE author
SET first_name = 'Alina',
last_name ='Koraki'
WHERE id =5 
--RETURNING * ile değiştirdiğimiz satırları anlık görüntüleriz
UPDATE author
SET first_name= 'update'
WHERE id=4
RETURNING * ;

--DELETE
DELETE FROM <tablo_adı>
WHERE <koşul_adı>;
--idsi 4 olan veriyi silmek istersek;
DELETE FROM author
WHERE id= 4
--3'ten küçük satırları silmek istersek
DELETE FROM author
WHERE id < 3 
RETURNING * ;

--PRIMARY KEY (Birincil Anahtar)
--O satırda bulunan asıl veriyi diğer verilerden ayrıştırabileceğimiz bir tanımlayıcıya ihtiyaç duyarız bu yüzden primary key kullanırız.
--Benzersiz olmalı.Bir tabloda 1 tane primary key bulunur.
CREATE TABLE order_items(
  order_id INT, 
  item_no SERIAL, 
  item_description VARCHAR NOT NULL, 
  quantity INTEGER NOT NULL, 
  price DEC(10, 2), 
  PRIMARY KEY (order_id, item_no)
);
--Bu şekilde sonda da belirtilebilir.
--Sonradan PRIMARY KEY belirlemek istersek ;
ALTER TABLE products 
ADD PRIMARY KEY (product_id);
--FOREIGN KEY
--Başka bir tablodaki primary key sütununu referans olarak gösterebiliriz.
--Bir tabloda birden fazla sütun FK olarak tanımlanabilir.
--Aynı sütunun içerisinde aynı değerler bulunabilir.


CREATE TABLE book (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	page_number INTEGER NOT NULL,
	author_id INTEGER REFERENCES author(id)
)

INSERT INTO book (title,page_number,author_id) VALUES ('White Banners',62,6);
INSERT INTO book (title,page_number,author_id) VALUES ('Saving Shilah',580,10);
INSERT INTO book (title,page_number,author_id) VALUES ('Abe Lincoln in illinois',105,5);
INSERT INTO book (title,page_number,author_id) VALUES ('Apache Terriority',286,5);
INSERT INTO book (title,page_number,author_id) VALUES ('Out 1: Spectre',402,45);
INSERT INTO book (title,page_number,author_id) VALUES ('Trials of Muhammed Ali',164,50);
INSERT INTO book (title,page_number,author_id) VALUES ('BUSTED (Everybody Loves Sunshine',84,10);
INSERT INTO book (title,page_number,author_id) VALUES ('Father Sergius',265,9);
INSERT INTO book (title,page_number,author_id) VALUES ('White Banners',62,29);
INSERT INTO book (title,page_number,author_id) VALUES ('Thirty Seconds over Tokyo',586,33);
INSERT INTO book (title,page_number,author_id) VALUES ('Cutie Honey',238,8);
INSERT INTO book (title,page_number,author_id) VALUES ('Baby on Board',339,7)

--author id'si 1 olan kitapları görmek istersek
SELECT * FROM book
WHERE author_id=1

--Kitap bilgileri yanısıra yazarların da bilgilerini görmek istersek JOIN sorgusunu kullanırız. Eşleşme; author tablosundan id, book tablosundan author_id olacak şekilde;
SELECT * FROM book
JOIN author ON author.id = book.author_id

--VERİ TİPLERİ
--https://www.postgresql.org/docs/13/datatype.html
--Hangi tip verileri yazacağımızı belirler.
--Postgresql 16 data types
--1 byte=8 bit, 2 byte=16 bit( en fazla 2^16 veri aralığı vardır yani 65536 civarına kadar değer alabilir.)
--SMALLINT(-32768 to +32768),INTEGER(4 bytes),BIGINT(8 bytes)
--SERIAL- tam sayı, otomatik artan,daima pozitif
--REAL  8 basamak,virgülden sonra 6. basamağı yuvarlar.DOUBLE PRECISION 15.basamaktan sonra yuvarlar.16 basamak,NUMERIC sayının kendisi
	
CREATE TABLE test (
	real_type REAL,
	double_type DOUBLE PRECISION,
	numeric_type NUMERIC );
INSERT INTO test 
VALUES
	(1.123456789123456789,
	1.123456789123456789,
	1.123456789123467897
);
--
CREATE TABLE test3 (
	float4_type FLOAT4,
	float8_type FLOAT8, 
	decimal_type DECIMAL );
INSERT INTO test3
VALUES
	(1.123456789123456789,
	1.123456789123456789,
	1.123456789123456789
);
	
--FLOAT4 = REAL
--FLOAT8=DOUBLE PRECISION
--DECIMAL=NUMERIC

--SELECT (1.444444444444::DOUBLE PRECISION)

--CHARACTER TYPES
--VARCHAR (10) yazarsak 10 karaktere kadar veri yazabiliriz.
--CHAR (10) sabit karakter sayısını ifade eder. 5 karakter yazarsak geri kalan karakteri boşlukla doldurur.
--TEXT herhangi bir kısıt yoktur.(unlimited)
--Karakter tiplerini test etmek için direkt SELECT komutunu kullanabiliriz.
SELECT ('Paris'::CHAR(15))
SELECT ('PradaK5'::VARCHAR(5))

--BOOLEAN TYPES
--TRUE:true,yes,on,1,t
--FALSE: false,no,off,0,f
--FALSE çıktısı veren sorgular
SELECT('0':: BOOLEAN);
SELECT('no':: BOOLEAN);
SELECT('off':: BOOLEAN);
--TRUE çıktısı veren sorgular
SELECT('1':: BOOLEAN);
SELECT('yes':: BOOLEAN);
SELECT('on':: BOOLEAN);
--
--NULL çıktısı için;
SELECT (NULL::BOOLEAN)

--DATE TYPES
SELECT('1990-05-25':: DATE);
SELECT('DEC-03-1980':: DATE);
SELECT('DEC 03 1980':: DATE);
SELECT('1990 December 19'::DATE);

--TIME TYPES
SELECT ('03:40 AM':: TIME)
SELECT ('03:40 PM':: TIME)
SELECT ('03:40':: TIME)
SELECT ('03:40:10':: TIME)
-
SELECT ('03:40':: TIME WITH THE TIME ZONE) 
çıktı:"03:40:00+03:00"

--Tarih ve Zamanı aynı anda göstermek istersek;
SELECT ('1990 December 05 03:40:10':: TIMESTAMP)
SELECT ('1990 DEC 12 03:40:10'::TIMESTAMP WITH TIME ZONE)

SELECT ('1990 DEC 12 03:40:10'::INTERVAL)
--"19900 years 12 days 03:40:10"


--NOT NULL - ALTER
CREATE TABLE users2 (
	id SERIAL PRIMARY KEY,
	username VARCHAR(20),
	email VARCHAR(50),
	age INTEGER
);
SELECT * FROM users2;

INSERT INTO users2 (username,email,age)
VALUES (
	'tester','tester@gmail.com','23'
)

INSERT INTO users2(email,age)
VALUES (
	'gester@gmail.com','23'
)

--username null olarak gözükür eğer username sütunun boş olmamasını istiyorsak NOT NULL kullanırız.CREATE TABLE kısmında belirttiğimiz komutları güncellerken 
--'users2' already exists hatası alırız.Bu sorunla karşılaşmadan kısıt eklemek istersek ALTER kullanılırız.
ALTER TABLE users2
ALTER COLUMN username
SET NOT NULL
--başta null veri girdiğimiz için hata verdi o yüzden username null olan verileri silebiliriz.
DELETE FROM users2 
WHERE username IS NULL 
RETURNING *; 
--sonrasında 
ALTER TABLE users2
ALTER COLUMN username
SET NOT NULL
-- komutunu gireriz.
--NULL bilinmeyen eksik bir veridir 0 değildir.





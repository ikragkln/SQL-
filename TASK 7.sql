--film tablosunda bulunan filmleri rating değerlerine göre gruplayınız.
SELECT rating,COUNT(*)FROM film
GROUP BY rating
ORDER BY COUNT(*);
--film tablosunda bulunan filmleri replacement_cost sütununa göre grupladığımızda film sayısı 50 den fazla olan replacement_cost değerini ve karşılık gelen film sayısını sıralayınız.
SELECT replacement_cost, COUNT(*) FROM film
GROUP BY replacement_cost
HAVING COUNT (*)>50;
--Customer tablosunda bulunan store_id değerlerine karşılık gelen müşteri sayılarını nelerdir?
SELECT store_id, COUNT(*) FROM customer
GROUP BY store_id;
--City tablosunda bulunan şehir verilerini country_id sütununa göre gruplandırdıktan sonra en fazla şehir sayısı barındıran country_id bilgisini ve şehir sayısını paylaşınız.
--country_id'ye göre şehir verileri
SELECT country_id, COUNT(*) FROM City
GROUP BY country_id;
--en fazla şehir barındıran;
SELECT country_id, COUNT(*) FROM City
GROUP BY country_id
ORDER BY COUNT (*) DESC
LIMIT 1;
--country_id:44 olan değer en fazla şehiri barındırıyor, detaylar için;
SELECT * FROM city
WHERE country_id = 44;

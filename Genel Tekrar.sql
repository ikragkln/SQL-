--film tablosundan 'K' karakteri ile başlayan en uzun ve replacement_cost u en düşük 4 filmi sıralayınız.
SELECT title, length, replacement_cost
FROM film
WHERE title LIKE 'K%'
ORDER BY length DESC, replacement_cost ASC
LIMIT 4;

--film tablosunda içerisinden en fazla sayıda film bulunduran rating kategorisi hangisidir?
SELECT rating,COUNT(*) AS film_count FROM film
GROUP BY rating
ORDER BY film_count DESC
LIMIT 1;

--customer tablosunda en çok alışveriş yapan müşterinin adı nedir?
SELECT customer.first_name,customer.last_name, SUM(payment.amount) AS "total_spent" FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id
ORDER BY "total_spent" DESC
LIMIT 1;

----film tablosunda isminde en az 4 adet 'e' veya 'E' karakteri bulunan kç tane film vardır?
SELECT COUNT(title) AS "min4eCount" FROM film
WHERE title ILIKE '%e%e%e%e%';


--category tablosundan kategori isimlerini ve kategori başına düşen film sayılarını sıralayınız.
SELECT category.name,COUNT(film_category.category_id) AS "film_number_category" FROM category
INNER JOIN film_category ON category.category_id=film_category.category_id
JOIN film ON film_category.film_id=film.film_id
GROUP BY category.name;

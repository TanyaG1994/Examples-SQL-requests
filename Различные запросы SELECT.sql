SELECT *
FROM customers
WHERE city = 'Berlin' OR city = 'London' OR city = 'San Francisco';


SELECT *
FROM orders
WHERE order_date BETWEEN '1998-03-30' AND '1998-04-03';


SELECT category_id, SUM(units_in_stock) --считаем сумму количества товаров в каждой категории
FROM products -- из таблицы продукты
GROUP BY category_id --группируем по категориям
ORDER BY SUM(units_in_stock) DESC -- сортировка по убыванию
LIMIT 5 -- кол выводимых значений


SELECT MAX (order_date) -- дата самого позднего заказа
FROM orders
WHERE ship_city ='London'


SELECT category_id, SUM(unit_price * units_in_stock) --выводим категории и сумму товаров в этой категории
FROM products
WHERE discontinued <> 1 -- т е находятся в продаже
GROUP BY category_id --группируем по категориям
HAVING SUM(unit_price * units_in_stock) > 5000 --пост фильтр - где сумма товаров больше 5000
ORDER BY SUM(unit_price * units_in_stock) DESC -- сортировка по убыванию суммы


SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers
EXCEPT
SELECT country
FROM employees
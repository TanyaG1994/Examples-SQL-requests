--Вывести продукты количество которых в продаже меньше самого малого среднего количества продуктов в деталях заказов (группировка по product_id). 
--   Результирующая таблица должна иметь колонки product_name и units_in_stock.
SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock < ALL (SELECT AVG(quantity)
							FROM order_details
							GROUP BY product_id)
ORDER BY units_in_stock DESC;



--Напишите запрос, который выводит 3 заказа с наибольшей стоимостью, которые были созданы после 1 сентября 1997 года 
--включительно и были доставлены в страны Южной Америки. Общая стоимость рассчитывается как сумма стоимости деталей заказа с 
--учетом дисконта. Результирующая таблица должна иметь колонки customer_id, ship_country и order_price, строки которой должны 
--быть отсортированы по стоимости заказа в обратном порядке.
SELECT customer_id, ship_country, order_price
FROM orders
JOIN (SELECT order_id,
      SUM(unit_price * quantity - unit_price * quantity * discount) AS order_price
      FROM order_details
      GROUP BY order_id) AS od
 USING(order_id)
 WHERE ship_country IN ('Argentina' , 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador', 'Guyana', 'Paraguay', 
						'Peru', 'Suriname', 'Uruguay', 'Venezuela')
   						AND order_date >= '1997-09-01'
 ORDER BY order_price DESC
 LIMIT 3;


 --Вывести все товары (уникальные названия продуктов), которых заказано ровно 10 единиц (конечно же, это можно решить и 
 --без подзапроса).
 SELECT DISTINCT product_name
 FROM products 
 WHERE EXISTS (SELECT product_id
 				FROM order_details
 				WHERE quantity = 10)
-- Vilka kunder har köpt svarta sandaler i storlek 38 av märket Ecco? Lista deras namn och använd inga hårdkodade id-nummer i din fråga.

SELECT `cst`.`name` FROM `shop_db`.`customers` AS `cst`
INNER JOIN `shop_db`.`orders` AS `ord` 
			ON `cst`.`id`=`ord`.`customer_id`
INNER JOIN `shop_db`.`order_items` AS `ord_item` 
			ON `ord`.`id` = `ord_item`.`order_id`
INNER JOIN `shop_db`.`shop_items` AS `shop_item`
			ON `ord_item`.`shop_item_id` = `shop_item`.`id`
INNER JOIN `shop_db`.`specifications` AS `spec`
			ON `shop_item`.`specification_id` = `spec`.`id`
INNER JOIN `shop_db`.`products`AS `prod`
			ON `shop_item`.`product_id` = `prod`.`id`
INNER JOIN `shop_db`.`brands` AS `brand`
			ON `prod`.`brand_id`=`brand`.`id`
INNER JOIN `shop_db`.`product_types` AS `prod_type`
			ON `prod`.`product_type_id` = `prod_type`.`id`
INNER JOIN `shop_db`.`products_categories` AS `prod_cat_junc`
			ON `prod`.`id` = `prod_cat_junc`.`product_id`
INNER JOIN `shop_db`.`categories` AS `cat`
			ON `prod_cat_junc`.`category_id` = `cat`.`id`
WHERE `prod_type`.`name` = 'Shoes' 
		AND `cat`.`name` = 'Sandals' 
        AND `spec`.`size` = 38 
        AND `brand`.`name` = 'Ecco'
GROUP BY `cst`.`id`;


-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter.
SELECT `cat`.`name` AS `category_name`, COUNT(`prod_cat_junc`.`category_id`) AS `num_products`  FROM `shop_db`.`products_categories` AS `prod_cat_junc`
INNER JOIN `shop_db`.`categories` AS `cat`
			ON `prod_cat_junc`.`category_id`=`cat`.`id`    
GROUP BY `cat`.`id`;    


        
-- Skapa en kundlista med den totala summan pengar som varje kund har handlat för. Kundens för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas.
SELECT `cst`.`name` AS `customer_name`, SUM(`prod`.`price`) AS `total_purchased_price_customer` FROM `shop_db`.`orders` AS `ord`
INNER JOIN `shop_db`.`customers` AS `cst`
			ON `ord`.`customer_id` = `cst`.`id`
INNER JOIN `shop_db`.`order_items` AS `ord_item`
			ON `ord`.`id`=`ord_item`.`order_id`
INNER JOIN `shop_db`.`shop_items` AS `shop_item`
			ON `ord_item`.`shop_item_id` = `shop_item`.`id`
INNER JOIN `shop_db`.`products` AS `prod`
			ON `shop_item`.`product_id` = `prod`.`id`
GROUP BY `cst`.`id`;            

-- Skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än 1000 kr. Ortnamn och värde ska visas. 
-- forts. (det måste finnas orter i databasen där det har handlats för mindre än 1000 kr för att visa att frågan är korrekt formulerad)
SELECT `area`.`name` AS `area_name`, SUM(`prod`.`price`) AS `total_purchased_price_area` FROM `shop_db`.`orders` AS `ord`
INNER JOIN `shop_db`.`shipping_adresses` as `adr`
			ON `ord`.`shipping_adress_id` = `adr`.`id`
INNER JOIN `shop_db`.`zip_codes` AS `zip`
			ON `adr`.`zip_code` = `zip`.`zip_code`
INNER JOIN `shop_db`.`areas` AS `area`
			ON `zip`.`area_id` = `area`.`id`
INNER JOIN `shop_db`.`order_items` AS `ord_item`
			ON `ord`.`id`=`ord_item`.`order_id`
INNER JOIN `shop_db`.`shop_items` AS `shop_item`
			ON `ord_item`.`shop_item_id` = `shop_item`.`id`
INNER JOIN `shop_db`.`products` AS `prod`
			ON `shop_item`.`product_id` = `prod`.`id`              
GROUP BY `area`.`id`
HAVING `total_purchased_price_area`>1000;            



-- Skapa en topp-5 lista av de mest sålda produkterna. 
SELECT `prod`.`name` AS `product_name`, COUNT(`shop_item`.`product_id`) AS `total_sold_units_product` FROM `shop_db`.`orders` AS `ord`
INNER JOIN `shop_db`.`order_items` AS `ord_item`
			ON `ord`.`id`=`ord_item`.`order_id`
INNER JOIN `shop_db`.`shop_items` AS `shop_item`
			ON `ord_item`.`shop_item_id` = `shop_item`.`id`
INNER JOIN `shop_db`.`products` AS `prod`
			ON `shop_item`.`product_id` = `prod`.`id`
GROUP BY `prod`.`id`
ORDER BY `total_sold_units_product` DESC
LIMIT 5;           




-- Vilken månad hade du den största försäljningen? (det måste finnas data som anger försäljning för mer än en månad i databasen för att visa att frågan är korrekt formulerad)
SELECT YEAR(`ord`.`date`) AS `year`, MONTH(`ord`.`date`) AS `month`, SUM(`prod`.`price`) AS `total_sold_price_month` FROM `shop_db`.`orders` AS `ord`
INNER JOIN `shop_db`.`order_items` AS `ord_item`
			ON `ord`.`id`=`ord_item`.`order_id`
INNER JOIN `shop_db`.`shop_items` AS `shop_item`
			ON `ord_item`.`shop_item_id` = `shop_item`.`id`
INNER JOIN `shop_db`.`products` AS `prod`
			ON `shop_item`.`product_id` = `prod`.`id`
GROUP BY `month`, `year`
ORDER BY `total_sold_price_month` DESC
LIMIT 1; 

-- TEST

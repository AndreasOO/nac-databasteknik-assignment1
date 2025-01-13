DROP SCHEMA IF EXISTS `shop_db`;
CREATE SCHEMA IF NOT EXISTS `shop_db`;
USE `shop_db`;

DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` ( `id` INT NOT NULL AUTO_INCREMENT,
						`name` VARCHAR(55) NOT NULL,
						 PRIMARY KEY (`id`)
					  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `product_types`;
CREATE TABLE `product_types` ( `id` INT NOT NULL AUTO_INCREMENT,
							   `name` VARCHAR(55) NOT NULL,
						       PRIMARY KEY (`id`)
							 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` ( `id` INT NOT NULL AUTO_INCREMENT,
							`name` VARCHAR(55) NOT NULL,
						    PRIMARY KEY (`id`)
						  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1; 
                             

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` ( `id` INT NOT NULL AUTO_INCREMENT,
						  `name` VARCHAR(55) NOT NULL,
                          `price` INT NOT NULL,
                          `brand_id` INT NOT NULL,
                          `product_type_id` INT NOT NULL,
                          CONSTRAINT `FK_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
                          CONSTRAINT `FK_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `product_types` (`id`),
						  PRIMARY KEY (`id`)
						  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
                          


DROP TABLE IF EXISTS `products_categories`;
CREATE TABLE `products_categories` ( `product_id` INT NOT NULL,								
									 `category_id` INT NOT NULL,
									 CONSTRAINT `FK_product_id_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
                                     CONSTRAINT `FK_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
									 UNIQUE KEY `product_categories_index` (`product_id`, `category_id`)
								   ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1; 
                          


DROP TABLE IF EXISTS `specifications`;
CREATE TABLE `specifications` ( `id` INT NOT NULL AUTO_INCREMENT,
							    `color` VARCHAR(55) NOT NULL,
                                `size` INT NOT NULL,
						        PRIMARY KEY (`id`)
							  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;                          
                          
                          
DROP TABLE IF EXISTS `shop_items`;
CREATE TABLE `shop_items` ( `id` INT NOT NULL AUTO_INCREMENT,
						  `product_id` INT NOT NULL,
                          `specification_id` INT NOT NULL,
                          `quantity` INT NOT NULL,
                          CONSTRAINT `FK_product_id_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
                          CONSTRAINT `FK_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `specifications` (`id`),
                          UNIQUE `unique_shop_item_index` (`product_id`, `specification_id`),
						  PRIMARY KEY (`id`)
						  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;                          
                        
                        
                        
DROP TABLE IF EXISTS `areas`;
CREATE TABLE `areas` ( `id` INT NOT NULL AUTO_INCREMENT,
					   `name` VARCHAR(55) NOT NULL,
					   PRIMARY KEY (`id`)
					 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1; 
                         


DROP TABLE IF EXISTS `zip_codes`;
CREATE TABLE `zip_codes` ( `zip_code` INT NOT NULL,
						   `area_id` INT NOT NULL,
                           CONSTRAINT `FK_area_id` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
						   PRIMARY KEY (`zip_code`)
						 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1; 
                         

DROP TABLE IF EXISTS `shipping_adresses`;
CREATE TABLE `shipping_adresses` ( `id` INT NOT NULL AUTO_INCREMENT,
								   `zip_code` INT NOT NULL,
                                   `street` VARCHAR(255) NOT NULL,
                                   CONSTRAINT `FK_zip_code` FOREIGN KEY (`zip_code`) REFERENCES `zip_codes` (`zip_code`),
								   PRIMARY KEY (`id`)
								 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1; 
               


                        
                        
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` ( `id` INT NOT NULL AUTO_INCREMENT,
							`email` VARCHAR(55) NOT NULL,
						    PRIMARY KEY (`id`)
						  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1; 
                          
       
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` ( `id` INT NOT NULL AUTO_INCREMENT,
						  `customer_id` INT NOT NULL,
                          `date` DATE NOT NULL,
                          `shipping_adress_id` INT NOT NULL,
                          CONSTRAINT `FK_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
                          CONSTRAINT `FK_shipping_adress_id` FOREIGN KEY (`shipping_adress_id`) REFERENCES `shipping_adresses` (`id`),
						  PRIMARY KEY (`id`)
						  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;        
       

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` ( `id` INT NOT NULL AUTO_INCREMENT,
						  `shop_item_id` INT NOT NULL,
                          `order_id` INT NOT NULL,
                          CONSTRAINT `FK_shop_item_id` FOREIGN KEY (`shop_item_id`) REFERENCES `shop_items` (`id`),
                          CONSTRAINT `FK_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
						  PRIMARY KEY (`id`)
						  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;         
                          
                          
-- ADDING DATA IN TABLES --   
-- _____________________ --         
-- _____________________ --         
-- _____________________ --         


INSERT INTO `shop_db`.`brands` (`name`) VALUES ('Ecco');
INSERT INTO `shop_db`.`brands` (`name`) VALUES ('Nike');
INSERT INTO `shop_db`.`brands` (`name`) VALUES ('Puma');
INSERT INTO `shop_db`.`brands` (`name`) VALUES ('Acne');

INSERT INTO `shop_db`.`product_types` (`name`) VALUES ('Shoes');
                      
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Bolt Runner', 500, 1, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Crazy Feet', 600, 2, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Goblin Mode', 900, 1, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Trackmaster', 1200, 4, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Lazy Sunday', 500, 3, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Little Feet', 350, 2, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Blaster', 1900, 2, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Heavies', 2500, 1, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Scooter', 950, 3, 1);
INSERT INTO `shop_db`.`products` (`name`, `price`, `brand_id`, `product_type_id`) VALUES ('Wranglers', 2700, 2, 1);



INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Sports shoes');
INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Running shoes');
INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Ladies shoes');
INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Men\'s shoes');
INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Walking shoes');
INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Children\'s shoes');
INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Walking shoes');
INSERT INTO `shop_db`.`categories` (`name`) VALUES ('Slim shoes');

INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (1,1);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (1,2);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (2,3);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (3,4);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (4,1);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (5,2);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (5,3);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (6,6);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (7,1);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (8,5);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (9,1);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (9,2);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (10,2);
INSERT INTO `shop_db`.`products_categories` (`product_id`, `category_id`) VALUES (10,4);




INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Black', 39);           
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Black', 40);  
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Green', 39);  
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('White', 39);  
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Red', 40);  
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Black', 41);  
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Gray', 39);  
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Blue', 40);  
INSERT INTO `shop_db`.`specifications` (`color`, `size`) VALUES ('Black', 41);


INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (1,1,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (1,2,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (2,1,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (2,2,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (3,1,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (4,1,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (4,2,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (4,6,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (4,9,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (2,4,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (3,2,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (3,9,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (1,6,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (2,9,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (5,1,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (5,2,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (6,1,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (6,6,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (6,9,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (7,3,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (7,5,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (8,9,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (9,8,100);
INSERT INTO `shop_db`.`shop_items` (`product_id`, `specification_id`, `quantity`) VALUES (10,7,100);



INSERT INTO `shop_db`.`areas`(`name`) VALUES ('Malmö');
INSERT INTO `shop_db`.`areas`(`name`) VALUES ('Stockholm');
INSERT INTO `shop_db`.`areas`(`name`) VALUES ('Göteborg');
INSERT INTO `shop_db`.`areas`(`name`) VALUES ('Lund');


INSERT INTO `shop_db`.`zip_codes` (`zip_code`, `area_id`) VALUES (22288, 4);
INSERT INTO `shop_db`.`zip_codes` (`zip_code`, `area_id`) VALUES (10358, 2);
INSERT INTO `shop_db`.`zip_codes` (`zip_code`, `area_id`) VALUES (10222, 2);
INSERT INTO `shop_db`.`zip_codes` (`zip_code`, `area_id`) VALUES (10111, 2);
INSERT INTO `shop_db`.`zip_codes` (`zip_code`, `area_id`) VALUES (20111, 1);
INSERT INTO `shop_db`.`zip_codes` (`zip_code`, `area_id`) VALUES (40231, 3);

INSERT INTO `shop_db`.`shipping_adresses` (`zip_code`, `street`) VALUES (22288, 'Låtsasgatan 11');
INSERT INTO `shop_db`.`shipping_adresses` (`zip_code`, `street`) VALUES (10358, 'Hittepåvägen 21');     
INSERT INTO `shop_db`.`shipping_adresses` (`zip_code`, `street`) VALUES (10222, 'Vasavägen 34');                      
INSERT INTO `shop_db`.`shipping_adresses` (`zip_code`, `street`) VALUES (10111, 'Storstadsidyllen 8');     
INSERT INTO `shop_db`.`shipping_adresses` (`zip_code`, `street`) VALUES (20111, 'Falaffelgatan 56');     
INSERT INTO `shop_db`.`shipping_adresses` (`zip_code`, `street`) VALUES (40231, 'Fiskavenyn 1');                               

INSERT INTO `shop_db`.`customers` (`email`) VALUES ('fake@email.com');
INSERT INTO `shop_db`.`customers` (`email`) VALUES ('no@person.com');
INSERT INTO `shop_db`.`customers` (`email`) VALUES ('jane@doe@mail.com');
INSERT INTO `shop_db`.`customers` (`email`) VALUES ('test@person.com');
INSERT INTO `shop_db`.`customers` (`email`) VALUES ('snabba@gubben.com');
INSERT INTO `shop_db`.`customers` (`email`) VALUES ('shopaholic@help.nu');



INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (1, '2024-12-16', 1);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (1, '2024-12-17', 1);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (2, '2024-12-19', 2);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (3, '2024-12-11', 3);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (3, '2024-12-12', 3);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (3, '2024-12-18', 3);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (4, '2024-12-05', 4);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (4, '2024-12-06', 4);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (4, '2024-12-13', 4);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (5, '2024-12-10', 5);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (5, '2024-12-11', 5);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (6, '2024-12-13', 6);
INSERT INTO `shop_db`.`orders` (`customer_id`, `date`, `shipping_adress_id`) VALUES (6, '2024-12-14', 6);




INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (1,1);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (2,1);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (3,1);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (1,2);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (1,2);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (6,2);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (7,3);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (8,3);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (9,3);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (10,4);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (2,4);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (5,4);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (11,5);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (14,5);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (15,5);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (16,5);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (24,6);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (6,6);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (19,7);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (2,7);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (20,8);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (17,9);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (18,10);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (22,11);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (11,12);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (23,13);
INSERT INTO `shop_db`.`order_items` (`shop_item_id`, `order_id`) VALUES (24,13);


































                          
                          
                          
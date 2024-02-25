	CREATE DATABASE IF NOT EXISTS transaction_test;  
	USE transaction_test;  
	  
	DROP TABLE IF EXISTS customer_accounts;  
	  
	DROP TABLE IF EXISTS customers;  
	  
	CREATE TABLE customers(  
	id int AUTO_INCREMENT PRIMARY KEY ,  
	name VARCHAR(255) NOT NULL ,  
	address VARCHAR(255)  
	)ENGINE=InnoDB;  
	  
	CREATE TABLE IF NOT EXISTS customer_accounts(  
	id INT AUTO_INCREMENT PRIMARY KEY ,  
	amount DOUBLE NOT NULL ,  
	currency VARCHAR(10),  
	customer_id INT NOT NULL ,  
	CONSTRAINT FOREIGN KEY (customer_id)   
	    REFERENCES customers(id)   
	    ON DELETE RESTRICT ON UPDATE CASCADE  
	)ENGINE=InnoDB;  
	  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Ivan Petrov Iordanov', 'Sofia, Krasno selo 1000');  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Stoyan Pavlov Pavlov', 'Sofia, Liuylin 7, bl. 34');  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Iliya Mladenov Mladenov', 'Sofia, Nadezhda 2, bl 33');  
	  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('5000', 'BGN', '1');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('10850', 'EUR', '1');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('1450000', 'BGN', '2');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('17850', 'EUR', '2');  

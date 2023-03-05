-- Restaurant 

-- D1: MENU
CREATE TABLE menu (
    menu_id INT PRIMARY KEY NOT NULL,
    menu_name TEXT,
    menu_price INT
  );

INSERT INTO menu VALUES 
    (1, 'Pizza',120 ),
    (2, 'Burger',90 ),
    (3, 'Fries',60),
    (4, 'Soft drinks',40 ),
    (5, 'Vanilla Ice-cream',50 );

-- D2: BRANCH
CREATE TABLE branch (
    branch_id INT PRIMARY KEY NOT NULL ,
    branch_name TEXT
);

INSERT INTO branch VALUES 
   (1,'The Street'),
   (2,'Central Rama9'),
   (3,'Emquartier');

-- D3: EMPLOYEE
CREATE TABLE employee (
	em_id INT PRIMARY KEY UNIQUE,
  	em_name TEXT,
    em_lastname TEXT,
    branch_id INT,
 	em_salary TEXT,
);

INSERT INTO employee VALUES 
	(1, 'Jane','Doe',1, 16000),
  	(2, 'Luca','Ronald',2, 16000),
    (3, 'Theo','Messi',3, 19000);


-- D4: CUSTOMER
CREATE TABLE customer (
    cus_id INT PRIMARY KEY NOT NULL,
    cus_name CHAR,
	cus_gender CHAR,
    cus_lname CHAR,
);
INSERT INTO customers VALUES   
    (1, 'Lisa','Dilma','F','32'),
  	(2, 'Daisy','Choi','F','19'),
    (3, 'Deen','Deluca','M','41'),
    (4, 'Lee','Jordan','M','26'),
    (5, 'Will','Smith','M','29');
  
-- D5: PAY METHOD
CREATE TABLE pay (
   pay_id INT PRIMARY KEY NOT NULL,
   pay_method TEXT,
);

INSERT INTO payment VALUES 
    (1, 'Cash'),
    (2, 'Credit Card'),
    (3, 'Promtpay');

	
-- F1: ORDER
CREATE TABLE orders (
    ord_id INT NOT NULL PRIMARY KEY,
	ord_date date
    cus_id INT,
    menu_id INT,
    branch_id INT,
    pay_id INT,
    amount INT,
    FOREIGN KEY (cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (em_id) REFERENCES employee(em_id),
    FOREIGN KEY (pay_id) REFERENCES payment(pay_id)
);

INSERT INTO orders VALUES 
    (1 ,20220102 ,5 ,2 ,3 ,1 ,1 ) ,
    (2 ,20220104 ,4 ,4 ,2 ,1 ,2 ) ,
    (3 ,20220106 ,3 ,2 ,2 ,1 ,1 ) ,
    (4 ,20220128 ,2 ,3 ,2 ,2 ,1 ) ,
    (5 ,20220129 ,1 ,1 ,1 ,2 ,1 ) ,
    (6 ,20220207 ,3 ,1 ,1 ,1 ,1 ) ,
    (7 ,20220207 ,3 ,4 ,3 ,3 ,2 ) ,
    (8 ,20220207 ,2 ,5 ,1 ,3 ,1 ) ,
    (9 ,20220209 ,1 ,5 ,2 ,1 ,1 ) ;

-- Q1: Top Spender in January 2022
-- Q2: Most favourite menu in 2022
-- Q3: Top sales branch in 2022

SELECT
	customer.cus_name, 
	count(orders.menu_id)*menu.menu_price*orders.amount AS Spent
FROM orders, customer, menu
Left Join customer_name on orders.cus_id = customer.cus_id
WHERE strftime('%Y%m', orders.ord_date) = '202201'
GROUP BY custmer.cus_name
ORDER BY Spent DESC;

SELECT 
	menu.menu_name, 
	count(orders.menu_id)*orders.amount AS Total_orders
FROM orders, menu
Left Join menu_name on orders.menu_id = menu.menu_id
group by menu.menu_name
order by Total_orders desc;

SELECT 	
	orders.branch_id,
	count(orders.menu_id)*menu_price*orders.amount AS Sales
FROM orders, menu, branch
Left Join branch_name on orders.branch_id = branch.branch_id
group by branch.branch_name
order by Sales desc;
	
-- UPDATE ITEM
update menu
set menu_name = 'Vanilla Soft-serve'
where menu_id = 5;

-- NEW BRANCH
create table new_branch (
    branch_id INT PRIMARY KEY NOT NULL ,
    branch_name TEXT
);
INSERT INTO new_branch VALUES 
   (4,'Terminal21');
   
SELECT * from branch
UNION
select * from new_branch;

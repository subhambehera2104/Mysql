systemctl start mysql
sudo mysql


mysql -u root -p -- start ---step1

show databases ; ---step2

use somanath_ecommerce_db ; ---step3

show tables ; ---step4

creat database somanath_ecommerce_db;
use somanath_e_commerce_db; ---step5

create table users(
    id integer auto_increment primary  key,
    name varchar(127) not null,
    email varchar(127)  not null,
    passward varchar(127)  not null,
    address varchar(1023),
    gender varchar(1)  not null,
    phone varchar(15)  not null,
    otp varchar(7),
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp
);

 show create table users; --- show create  all table users ---step6
 desc users;


insert into users(name,email,passward,address,gender,phone,otp)
        values("sai", "sai@gmail.com", "654@56", "vishakapatanam", "m", "4567891230", "987456"); --frist insert a users
                                                             --------select * from users;
insert into users(name,email,passward,address,gender,phone,otp)         
        values("dev", "dev@gmail.com", "1234@56", "krupasindupalli", "m", "7894561230", "987654"), -- at a time two users insert
             ("som", "som@gmail.com", "986@113", "bhubaneswar", "m", "8260081664", "789654");
insert into users( name,email,passward,address,gender,phone,otp)
        values("roja", "roja@outlook.com","789@654", "vishakapatnam", "f", "4563217890", "852963");

insert into users( name,email,passward,address,gender,phone,otp)
        values("nandini", "nandini@outlook.com","852@741", "hyderabad", "f", "4563217890", "852963");             
             

-- gives number of rows 
select count(*) from users;
select count(name) from users; 
select name,email from users;  -- show name,email user table 
select * from users where name="som"; -- only som name show
select * from users where name like "s%";  -- only s letter name show
select * from users where name like "%v"; --- only last name show 
select * from users where address like "%sin%"; -- only middle address show  
update users set name="somanath" where id=1; --- new name update a row 
delete from users where id=3;   
select * from users;

create table products(
    id integer auto_increment primary  key,
    name varchar(63) not null,
    description varchar(127),
    specfication varchar (127),
    sale_price integer (255),
    discount integer (127),
    quantity integer (99),
    color varchar(7),
    mrp integer(127),
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp
);

 show create table products; ---show create table products;

 alter table products add column name varchar(63) not null after id; -- new products insert


 insert into products(name, description, specfication, sale_price, discount,quantity, color, mrp )
     values("mobile","this mobile is realme", "o", "1000","50%","8","blue","1200"),
           ("tv","this is samsung tv", "0","3000", "30%", "7", "blck", "4000"),               -------select * from products;
           ("filter", "this is a filter", "0", "5000", "30%", "9", "white", "6000");
select * from products;
select name, mrp from products where mrp <=4000;
select name, mrp from products where mrp >=4000;

-- Most expensive ( high or maximum cost)
select max(mrp) from products;

-- Cheapest or less expensive (low cost)
select min(mrp) from products;
------------------------------------------

create table carts(
    id integer auto_increment primary key,
    user_id integer references users(id) on delete cascade,
    created_at datetime default current_timestamp,             -----------show create table carts;
    modified_at datetime default current_timestamp
    );

or

create table carts(
    id integer auto_increment,
    user_id integer,
    created_at datetime default current_timestamp,
	modified_at datetime default current_timestamp,
	primary key(id),
    foreign key(user_id) references user(id) on delete cascade); ----table column delete--

 alter table carts add column user_id integer(11) not null after id; ----add table colum--

insert into carts(user_id)
values(1),
      (3),
      (5);

insert into carts(user_id)
  values(1),
        (3),
        (5);           

insert into carts(id, user_id)
values (7, 3),   -----select * from carts;
       (8,6);     

desc carts;
alter table carts drop column users_id;
alter table carts add column user_id integer;
alter table carts drop column user_id;
alter table carts add column user_id integer foreign key references user(id) on delete cascade;
alter table carts add  column user_id integer not null after id;  -----doubte--
-----------------------------------------------------------------------------------

create table cart_items(   ----show create table cart_items;
	id integer auto_increment primary key,
	cart_id integer,
	product_id integer references products(id) on delete cascade, 
    quantity integer);

insert into cart_items(cart_id, product_id, quantity)
values(1, 3, 3),                                 
(1, 4, 1),  ------ select * from cart_items;
(11, 9, 1);

create table orders(
	id integer auto_increment primary key,
	cart_id integer references carts(id) on delete cascade,
	order_total_amount decimal (10,2),
	discount decimal (10,2),   -------------show create table orders;
	created_at datetime default current_timestamp,
	modified_at datetime default current_timestamp);

insert into orders(cart_id, order_total_amount, discount)
values(7,627, 0),           -----select * from orders;
      (11, 75, 70);
desc orders;
update orders set cart_id=1 where id=1;
delete from orders where id in(3);   
update orders set id=3 where cart_id=11; 
------------------------------------------------------------

create table order_items (     
	id integer auto_increment primary key,
	order_id integer references orders(id) on delete  cascade,
	product_id integer references products(id) on delete cascade,
	product_name varchar(255),
	product_description varchar(1023),
	product_mrp decimal(10,2),                    -----show create table order_items;
	product_sale_price decimal(10,2),
	quantity integer,
	created_at datetime default current_timestamp,
	modified_at datetime default current_timestamp
	); 
     
insert into order_items(order_id, product_id, product_name, product_description, product_mrp, product_sale_price, quantity)
values(1, 3, "Pen2", "This pen color is blue", 160.50, 150, 3),
      (1, 4, "Book2", "This Book is math", 1.20, 1.20, 1),
      (2 ,5, "pen1,","This pen is black", 5.50, 4, 1),
      (2, 6, "Book1,", "This book is scienc", 199, 199,1),       ------ select * from orders_items;
      (2, 7, "Pen2", "This pen is No:1", 10, 9, 1),
      (2, 8,"Book2", "This book is english", 299, 297, 1);
desc order_items;
select u.name, u.email, ci.* from users u
join carts c on u.id=c.user_id               ----doubte--
join order_items ci on c.id= ci.cart_id
where u.id=3;           
delete from order_items where product_id in (7,8);
update order_items set quantity=5 where id=10;
----------------------------------------------------

create table payment_methods(
	id integer auto_increment primary key,  -----show create table payment_methods;
	name varchar(1023),
	config json );
insert into payment_methods(name, config)
values ("cash", '{}'),
       ( "Phonepe", '{"user_name": "abc", "passward": "1234556"}'),  ----- select * from payment_methods;
	   ( "paytm", '{"user_name": "abc", "passward": "1234556"}');
-----------------------------------------------------------------------

create table payments(
	id integer auto_increment primary key,
	order_id integer references orders(id) on delete cascade,  ------show create table payments;
	payment_method_id integer,
	payment_amount decimal(10,2));
insert into payments(order_id, payment_method_id, payment_amount)
values(1, 1, 600),    ---------select * from payments;
      (2, 2, 798);
desc payments;
----------------------------------------------------------

create table return_orders(id integer auto_increment primary key,
amount decimal (10,2),
payment_method_id integer references payment_methods(id) on delete cascade,  ------ show create table return_orders;
created_at datetime default current_timestamp,
modified_at datetime default current_timestamp);
insert into return_orders(payment_method_id)
values(1);
update return_orders o set amount = (select sum(product_sale_price*quantity) from order_items oi where order_id=1)
------------------------------------------------------------------------

create table return_items(
id integer auto_increment primary key,
return_order_id integer references orders(id) on delete cascade,
order_item_id integer references order_items(id) on delete cascade,
product_name varchar(511),
product_mrp decimal(10,2),
product_sale_price decimal(10,2),    ----------- show create table return_items;
quantity integer, 
reason varchar(1023),
created_at datetime default current_timestamp,
modified_at datetime default current_timestamp);  


insert into return_items(return_order_id, order_item_id, product_name, product_mrp, product_sale_price, quantity, reason)
values(1, 1, "Pen2", 160.50, 150, 2, "item defective");   ------select * from return_items;
-----------------------------------------------------------------










select sum(mrp) from products;
select id, mrp from products where id = 1;
select * from products where name like "m%";
select * from products where name like "%t";
select count(*) from products;
select * from products where mrp <=2000;
select * from products where mrp >10 and mrp <2000;
select * from products where year(created_at)=2024;
select * from products where month(created_at)=3;
select year(created_at), count(*) from products group by year(created_at);
select year(created_at), count(*) from products group by year(created_at) order by year(created_at) desc;   -- // desc means descending order 
select * from products order by name asc;   --------- // asc means ascending order
select * from products order by name desc;
select year(created_at), count(*) from orders group by year(created_at) order by year(created_at) desc;
update orders o set order_total_amount =(select sum(product_sale_price*quantity) from order_items oi where oi.order_id = 2)where o.id=2;  ---DOUBTE


update orders o set order_total_amount =(select sum(product_sale_price*quantity) from order_items oi where oi.order_id = 2) where o.id=2;  ----select * from orders where id =2;


select u.id, u.name, o.id, oi.*, o.created_at, pm.name from users u
join carts c on u.id = c.user_id
join orders o on o.cart_id = c.id 
join order_items oi on oi.order_id = o.id            ---doubte
join payments p on p.order_id = o.id
join payment_methods pm  on pm.id = p.payment_method_id;  

select date(created_at), sum(quantity) from order_items where product_id = 5 group by date(created_at);
--------------------------------------------------------------------------------------------------------

insert into users(name, email, passward, phone) 
	values("dev", "dev@gmail.com", "4651@58", "1554358");   ------- select * from users;

insert into products(name, description, mrp, sale_price) 
values("duster", "This duster is use a clear the blacKbord", 80.50, 75),  -----select * from products;
("keybord", "this keybord is zebronice", "400", "350");    

insert into carts(user_id)  ----select * from carts;
values(5);

insert into cart_items(cart_id, product_id, quantity)  ---select * from carts where user_id =5;
values(11, 9, 1);


insert into orders(cart_id, order_total_amount, discount)   
values(11, 75, 70);

insert into order_items(order_id, product_id, product_name, product_description, product_mrp, product_sale_price, quantity)
values(3, 9, "duster", "This duster is use a clear the blacKbord",  80.50, 75, 1);   ----select * from cart_items where cart_id =11;






             ----all quers runs----
  ---------------------------------------------
  
    mysql -u root -p
    passward 12345678

    show database;
    use somanath_e_commerce_db;

    select * from users;
    select name,email,id from user;
    select * from users where name="dev";
    select * from users where name like "%dev";
    select * from users where name like "%v";
    select count(*) from users;
    select count(*) from users where name like "%dev";
    select count(name) from users;
    select name from users where phone like "%81%";

----------------------------------------------------------------------------------------------------------------------------------


select * from users where email="som@gmail.com";

select gender from users; ---select users all distinct grnders

select distinct gender from users; -- Select users with distinct genders

select * from users where length(phone) >9;     -- Select users with mobile longer than 9 characters: 

select * from users where length(phone) >10;

select * from users where length(phone) >=10; 

select * from users order by name asc;  -- Select all users ordered by their name in ascending order

select * from users order by name desc;  -- Select all users ordered by their name in descending order

select * from  users limit 2;  -- Select 2 users:

select * from users ORDER BY created_at DESC LIMIT 2; -- Select 2 new users

select * from users ORDER BY created_at ASC LIMIT 2; -- Select 2 old or first 2 users:

select * from users ORDER BY created_at ASC;

select * from users WHERE gender = 'M' ORDER BY created_at ASC LIMIT 1; -- Select the oldest male user:

select * from users WHERE gender = 'M' ORDER BY created_at ASC;

select * from users WHERE gender = 'm' ORDER BY created_at DESC LIMIT 1;  -- Select the newest male user:

select * from users WHERE created_at = (select MAX(created_at) from users);  -- Select the user with the latest registration date

select * from users WHERE name LIKE 'dev%' AND gender = 'm'; -- Select all users whose names start with 'dev' and are male(m)

select * from users WHERE name LIKE 'a%' OR name LIKE 'b%'; -- Select users with names starting with 'a' or 'b'

select * from users where name like '%dev%';  -- Select users with names containing 'dev'

select * from users where name like '%v';  -- Select users with names ending with 'a'

SELECT * FROM users ORDER BY name ASC, phone ASC;  -- Select users ordered by name and mobile

select count(*) as male_users_count from users where gender='m'; -- Count the number of female users

SELECT gender, COUNT(*) AS user_count FROM users GROUP BY gender; -- Select all users and group them by gender

SELECT gender, COUNT(*) AS user_count FROM users GROUP BY gender ORDER BY user_count DESC;  -- Select users grouped by gender ordered by user count in descending order

SELECT DISTINCT SUBSTRING_INDEX(email, '@', -1) AS email_domain FROM users ORDER BY email_domain; -- Select users with distinct email domains ordered by email domain:

SELECT YEAR(created_at) AS registration_year, COUNT(*) AS user_count FROM users GROUP BY registrati


create table user_addresses(
    id integer auto_increment primary key,
    user_id integer references users_id,
    title varchar(127) not null,
    phone varchar(15) not null,
    house_number varchar(15) not null,
    street varchar(127) not null,
    landmark varchar(127) not null,
    city varchar(127) not null,
    state varchar(127) not null,
    country varchar(127) not null,
    is_primary varchar(1) not null,
    created_at datetime default current_timestamp,
    modifide_at datetime default current_timestamp
);

drop table user_addresses;

insert into user_addresses(title, phone, street, landmark, city, state, country, is_primary, house_number)
       values("somanath","9861136890","big","near school", "krupasindhupalli", "odisha", "india", "1", "69");

insert into user_addresses(title, phone, street, landmark, city, state, country, is_primary, house_number)
       values("narayan","7894561230","small"," mangal mandir", "khordha", "odisha", "india", "0", "75");

insert into user_addresses(title, phone, street, landmark, city, state, country, is_primary, house_number)
       values("bala","9876543217","main","rk beach", "vishakapatanm", "andhra pradesh", "india", "1", "85");

insert into user_addresses(title, phone, street, landmark, city, state, country, is_primary, house_number)
       values("ramesh","3216549872","6th line","church", "bangolore", "karnataka", "india", "1", "95");



select * from user_addresses where state="odisha";
select * from user_addresses where state="andhra pradesh";
select * from user_addresses where state="karnataka";

select * from user_addresses where city like 'ba%';
select * from user_addresses where city like '%ol%';
select * from user_addresses where city like '%re';
select * from user_addresses where country like '%andhra pradesh%';
# Thêm dữ liệu vào  bảng

use crm_demo;
Insert into customer(first_name, last_name, date_of_birth, sex, address, phone_number)
values
    ('Nguyen Van','A','2000-12-12',1,'Nghe An','0984586468'),
    ('Nguyen Van','B','2000-10-12',1,'Nghe An','0988585468'),
    ('Nguyen Van','C','2000-12-10',1,'Nghe An','0989686468'),
    ('Nguyen Van','D','2001-12-12',1,'Nghe An','0945686468'),
    ('Nguyen Van','E','2002-12-12',0,'Nghe An','0984567468');
Insert into employee(fullName, date_of_birth, sex, address, phone_number, department, status)
values
    ('Ha Huong Giang','2002-10-10',0,'Ha Noi','0498977646','Sales',1),
    ('Tran Duc Uy','2001-10-10',1,'Ha Noi','0498904746','Sales',1),
    ('Phung Duc Dang','2003-10-10',1,'Ha Noi','0448745346','Sales',1),
    ('Bui Dinh Duc','2004-10-10',1,'Ha Noi','0498345646','Sales',1),
    ('Do Quang Anh','2005-10-10',1,'Ha Noi','0498974546','Sales',1);

select * from employee;

Insert into contract(name, value, begin_at, expiry_at, employee_id, customer_id, status)
values
    ('Du an VLXD',10000000000,'2023-10-10','2033-10-10',1,4,'Prepare'),
    ('Du an Game',15000000000,'2010-10-10','202-10-10',2,1,'Done'),
    ('Du an Khu đô thị',1000000000000,'2023-10-10','2043-10-10',1,3,'Prepare'),
    ('Du an Khu nghỉ dương',1000000000,'2023-10-10','2030-10-10',3,5,'Prepare'),
    ('Du an Chung cư cao cap',5000000000,'2023-10-10','2040-10-10',5,2,'Prepare');

Insert into transaction(title, content, contract_id, amount, created_at, status)
values
    ('Dat coc du an','dat coc du an game',2,1500000000,'2010-10-10',1),
    ('Dat coc du an','dat coc du an VLXD',1,1500000000,'2010-10-10',1),
    ('Dat coc du an','Du an chung cu',5,500000000,'2010-10-10',1),
    ('Dat coc du an','du an khu nghi duong',4,1500000000,'2010-10-10',1),
    ('Dat coc du an','khu do thi',3,150000000,'2010-10-10',1);




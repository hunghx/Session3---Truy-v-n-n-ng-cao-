use crm_demo;

select *
from customer
where sex = 1
  and first_name like 'nguyen%';
select *
from customer
where date_of_birth >= '2001-01-01';
select *
from customer
where date_of_birth <> '2001-12-12';
select *
from customer
where date_of_birth between '2000-01-01' and '2000-12-31';

select *
from customer
where last_name not in ('A', 'B', 'C');


select *
from customer
where first_name like 'N_uyen%';
-- kí tự %, _

# câu lệnh join :  kêt hợp của 2 hoặc nhiều bảng với nhau

#Inner join
select concat(c.first_name, ' ', c.last_name) full_name, ct.*
from customer c
         join contract ct on c.id = ct.customer_id;
select *
from employee e
         inner join contract c on e.id = c.employee_id;
#left join / right join
select *
from employee e
         left join contract c on e.id = c.employee_id;
select *
from contract c
         right join employee e on e.id = c.employee_id;

select e.fullName `tên nhan viên`, c.name `tên dự án`, concat(cu.first_name, ' ', cu.last_name) `tên khách hàng`
from employee e
         inner join contract c on e.id = c.employee_id
         join customer cu on cu.id = c.customer_id;


select first_name
from customer
where sex = 1;

# bai toán : đếm số lượng nam , nư cua khách hàng

select *
from (select count(*) nu from customer where sex = 0) t1
         join
         (select count(*) nam from customer where sex = 1) t2;

# bài toán  : tính gia trị giao dịch của tất cả hợp đồng theo từng khách hàng
select customer_id, first_name, last_name, phone_number, sum(value)
from contract
         join customer on contract.customer_id = customer.id
group by customer_id;


# lấy nhưng khach hang có tong hop dong >= 100 tỏi
select customer_id, first_name, last_name, phone_number, sum(value)
from contract
         join customer on contract.customer_id = customer.id
group by customer_id
having sum(value) >=100000000000;


# thống kê số luong hợp đồng theo từng khách hàng
select customer_id, first_name, last_name, phone_number , count(contract.id) soluong
from contract
         join customer on contract.customer_id = customer.id
group by customer_id
having soluong >= 2 ;

# Order by

select customer_id, first_name ho, last_name ten, phone_number , count(contract.id) soluong
from contract
         join customer on contract.customer_id = customer.id
group by customer_id
order by ho,customer_id ;


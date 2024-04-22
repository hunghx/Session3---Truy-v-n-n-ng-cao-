# page = 19
# size = 20
# offset = page*size
explain analyze select name from world.city where Name like 'ch%';

# chua co chi muc
#-> Filter: (world.city.`Name` like 'ch%')  (cost=435 rows=456) (actual time=0.246..3.41 rows=79 loops=1)
#   -> Table scan on city  (cost=435 rows=4104) (actual time=0.098..2.54 rows=4079 loops=1)
#-> Filter: (city.`Name` like 'ch%')  (cost=18 rows=79) (actual time=0.0677..0.616 rows=79 loops=1)
#   -> Covering index range scan on city using index_name over ('ch' <= Name <= 'ch􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿')  (cost=18 rows=79) (actual time=0.062..0.586 rows=79 loops=1)

use  world;

CREATE index index_name
    on city(name);


#  Tạo thủ tục
DELIMITER //
CREATE PROCEDURE proc_get_all_city()
begin
    select * from world.city;
end ;
//
# gọi thủ tục
CALL proc_get_all_city();


# tao thủ tục thêm mới và trả v giá tri id mới vừa thêm

DELIMITER //
CREATE PROCEDURE proc_add_new_city(name_in char(35),code_in char(3), district_in char(20), population_in int , OUT new_id int)
begin
    insert into city(Name, CountryCode, District, Population) value (name_in,code_in,district_in,population_in);
    select last_insert_id() into new_id;
end ;
//

CALL  proc_add_new_city('DA NĂNG','VNM','Viet nam',500000,@new_id);
select @new_id;

# xóa thủ tuc
DROP PROCEDURE proc_add_new_city;

# khung nhìn
CREATE VIEW view_country
AS
select  Code,Name,Population  from country;

select * from view_country;

create view vietnam_city
as
select * from city where CountryCode like 'VNM' with check option ;

update vietnam_city set CountryCode = 'AGO' ;

# Trigger :trình tự kích hoạt - là 1 thủ tục nhưng , tự khởi chạy


CREATE  database  bank;
use  bank;

CREATE  table account(
    id int auto_increment primary key ,
    name varchar(50),
    balance int
);
-- trư  tiền tài khoản
update account set balance = balance-100 where  id = 1;


CREATE trigger check_balance
    before update on account
    for each row
    begin
#         declare balance_current int default 0;
#         Select balance into balance_current from account where id = NEW.id;
        if NEW.balance < 0 then
           signal sqlstate '45000' set MESSAGE_TEXT = 'Tai khoan ko thể âm';
        end if ;
    end ;



# Transaction
# tạo thủ tục chuyển tiền tư 2 tai khoan

DELIMITER //
CREATE PROCEDURE send_money(id_sender int, id_receiver int , amount int)
begin
   START TRANSACTION ;
   SET AUTOCOMMIT = 0;
   update account set balance = balance + amount where id = id_receiver;
   update account set balance = balance - amount where id = id_sender;
   COMMIT ;
end ;
//

call send_money(2,1,500);

# ý 2 : 2.	View v_getTicketList hiển thị danh sách Ticket gồm: Id, TicketDate,
# Status, CusName, Email, Phone,TotalAmount
# (Trong đó TotalAmount là tổng giá trị tiện phải trả,
# cột Status nếu = 0 thì hiển thị Chưa trả, = 1 Đã trả, = 2 Quá hạn, 3 Đã hủy)
CREATE  view  v_getTicketList
as
Select t.id,t.TicketDate, case t.status when 0 then 'Chưa trả'
                                        when 1 then 'Đã trả'
                                        when 2 then 'Quá hạn'
                                        when 3 then 'Đã hủy'
                                        END , c.name, c.email, c.phone , sum(td.quantity * td.DeposiPrice * (100-td.RentCost)/100)
from Ticket t join Customer c on t.CustomerId = c.Id
join TicketDetail td on t.id = td.tiketId
group by t.id;
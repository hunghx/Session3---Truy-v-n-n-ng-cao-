explain analyze
select name
from world.city
where name like 'ch%';

# -> Filter: (world.city.`Name` like 'ch%')  (cost=435 rows=456) (actual time=0.0772..1.36 rows=79 loops=1)
#     -> Table scan on city  (cost=435 rows=4104) (actual time=0.032..1 rows=4076 loops=1)

# -> Filter: (world.city.`Name` like 'ch%')  (cost=18 rows=79) (actual time=0.0225..0.0904 rows=79 loops=1)
#     -> Covering index range scan on city using index_name over ('ch' <= Name <= 'ch􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿􏿿')  (cost=18 rows=79) (actual time=0.0199..0.0783 rows=79 loops=1)


# tạo index cho cọt name
create index index_name
    on world.city (name);

# tao thủ tuc : tìm kiem tương dối tên thành phố
use world;

delimiter  //
create procedure proc_search_city_by_name(in search_name varchar(35))
begin
    select * from city where Name like concat('%', search_name, '%');
end;
delimiter //
# gọi thu tục
call proc_search_city_by_name('vinh');

# th tục thêm mới thành phố
drop procedure proc_add_city;
delimiter  //
create procedure proc_add_city(Name_IN char(35), countryCode_IN char(3), District_IN char(20), Population_IN int,
                               OUT ID_OUT int)
begin
    insert into city(Name, CountryCode, District, Population) value (Name_IN, countryCode_IN, District_IN, Population_IN);
    #     select last_insert_id() into ID_OUT from city;
#     select id into ID_OUT from city order by ID desc limit 1;
    select max(id) into ID_OUT from city;
end;

delimiter //
call proc_add_city('Vinh', 'VNM', 'TP Vinh', 300000, @id_new);

select @id_new;

delimiter  //
create procedure proc_update_city(Name char(35), countryCode char(3), District char(20), Population int, ID int)
begin
    update city
    set Name= Name,
        CountryCode=CountryCode,
        District = District,
        Population =Population
    where ID = ID;
end;

# tạo thủ tục them moi sp
use demo_02;
delimiter //
create procedure proc_insert_product(name_in varchar(50), price_in decimal(10, 2), class_id_in int, des_in text,
                                     image_url_in varchar(255))
begin
    # khai báo biến
    declare level_in varchar(10) default '';

    if price_in < 1000000 then
        set level_in = 'ECO';
    elseif price_in < 10000000 then
        set level_in = 'NORMAL';
    else
        set level_in = 'LUXURY';
    end if;
    insert into product(name, price, class_id, description, image_url, level)
        value (name_in, price_in, class_id_in, des_in, image_url_in, level_in);
    update catalog set count = count + 1 where id = class_id_in;
end;


call proc_insert_product('áo dai ', 900000, 7, 'gê gê', 'exp.jpg');

insert into product(name, price, class_id, description, image_url, level)
    value ('quan', 100, 8, 'hehe', 'bbcdnbcd', 'LUXURY');


# View(READ - WRITE) - Bảng ảo

create view view_product_catalog
as
select p.*, c.id catalog_id, c.name catalog_name, c.count
from product p
         join catalog c
              on p.class_id = c.id
where c.name in ('áo', 'quần');


select *
from view_product_catalog;
insert into view_product_catalog(id, name, price, class_id, description, image_url, level)
    value (100, 'áo ngắn', 100, 8, 'hhehe', 'img', 'ECO');

# chú ý : ko nên thực hiện các thao tác chỉnh sua trên view;
# xóa catalog thì toàn bộ product cook cùng

alter table product
    add constraint product_ibfk_1 foreign key (class_id) references catalog (id)
        on delete cascade;



delete
from product
where id = 2; -- chi xóa product đấy thôi
delete
from catalog
where id = 8;
-- xóa hết product cat = 8


# trigger - trình tự kích hoạt (insert | Update | Delete)
# thêm moiw vào bảng student và kiểm tra xem ngay có > ngày hiện tại ko
use demo_05;
create trigger before_insert_student
    before insert
    on student
    for each row
begin
    if NEW.dob > curdate() then
        signal sqlstate '45000' set message_text = 'ngay sinh ko the la ngay trong tuong lai';
    end if ;
end ;


insert into student(name, dob) value ('nguyen van anh','2024-04-23');


# transaction - giao dịch - phiên

create database  VQ_bank_QA;
use VQ_bank_QA;

create table account(
    id int auto_increment primary key ,
    name varchar(50),
    balance int
);



drop  procedure  send_money;
delimiter  //
create procedure send_money(id_sender int ,  id_receiver int , amount int)
begin
    start transaction ; -- bắt đầu giao dịch
    set autocommit = 0; -- cờ go lệnh commit thì mơ cập nht
    update account set balance = balance + amount where id = id_receiver; -- công tiên
    update account set balance = balance - amount where id = id_sender; -- công tiên
    commit ;
end ;
delimiter //

call send_money(1,2,500000);









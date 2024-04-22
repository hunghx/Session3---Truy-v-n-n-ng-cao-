create database second_db;
use second_db;
CREATE TABLE persons
(
    id         int primary key ,
    last_name  varchar(255) not null ,
    first_name varchar(255) not null ,
    age        int not null check ( age > 0 ) default 18,
    phone varchar(11) not null unique,
    address_id int not null,
    foreign key (address_id) references address(id)
);

create table address(
    id int primary key ,
    details  varchar(100)
);

drop  table persons;


# Ràng buộc Not null
alter table persons
modify id int not null ;
# Ràng buộc unique
# Ràng buộc check
alter table persons
add constraint check_first_name check ( length(first_name) >=4);
# Khóa chính
# Khóa chính tổ hợp / phức hợp
# Khóa ngoại



# insert into persons(id, last_name, first_name,phone) value (1, 'ho', 'hun','0989873934');




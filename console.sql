#Tao CSDL
CREATE DATABASE if not exists crm_demo;

Use crm_demo;

# bảng hợp đồng
CREATE table if not exists Contract
(
    id          int auto_increment primary key, -- tự tăng
    name        varchar(50),
    value       bigint,
    begin_at    date,
    expiry_at   date,
    employee_id int,
    customer_id int,
    status      enum ('Cancel','Prepare','Done')
);

#Bảng khách hàng
CREATE TABLE if not exists Customer
(
    id            int auto_increment primary key,
    first_name    varchar(50),
    last_name     varchar(50),
    date_of_birth date,
    sex           bit,
    address       varchar(50),
    phone_number  varchar(20)
);

# Bảng Nhân viên
CREATE TABLE if not exists Employee
(
    id            int auto_increment primary key,
    fullName      varchar(50),
    date_of_birth date,
    sex           bit,
    address       varchar(50),
    phone_number  varchar(20),
    department    varchar(50),
    status        bit
);

#Bảng giao dịch
CREATE TABLE if not exists Transaction
(
    id          int auto_increment primary key,
    title       varchar(50),
    content     varchar(100),
    contract_id int,
    amount      int,
    created_at  date,
    status      bit
);

# thêm quan hệ
ALTER table Contract
    add constraint fk_01 foreign key (employee_id) references Employee(id);
ALTER table Contract
    add constraint fk_02 foreign key (customer_id) references Customer(id);
ALTER TABLE Transaction
    add constraint fk_03 foreign key (contract_id) references Contract(id);

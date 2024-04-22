create database quanlybanhang;
use quanlybanhang;

#Bang khachhang
create table KHACHHANG
(
    makh     varchar(4) primary key,
    tenkh    varchar(30) not null,
    diachi   varchar(50),
    ngaysinh datetime,
    sodt     varchar(15) unique
);

create table nhanvien
(
    manv       varchar(4) primary key,
    hoten      varchar(30) not null,
    gioitinh   bit         not null,
    diachi     varchar(50) not null,
    ngaysinh   datetime    not null,
    dienthoai  varchar(15),
    email      text,
    noisinh    varchar(20) not null,
    ngayvaolam datetime,
    manql      varchar(4)
);

create table nhacungcap
(
    mancc     varchar(5) primary key,
    tenncc    varchar(50) not null,
    diachi    varchar(50) not null,
    dienthoai varchar(15) not null,
    email     varchar(30) not null,
    website   varchar(30)
);

create table loaisp
(
    maloaisp  varchar(4) primary key,
    tenloaisp varchar(30)  not null,
    ghichu    varchar(100) not null

);


create table sanpham
(
    masp      varchar(4) primary key,
    maloaisp  varchar(4)  not null,
    tensp     varchar(50) not null,
    donvitinh varchar(10) not null,
    ghichu    varchar(100)
);

create table phieunhap
(
    sopn     varchar(5) primary key,
    manv     varchar(4) not null,
    mancc    varchar(5) not null,
    ngaynhap datetime   not null default now(),
    ghichu   varchar(100)
);

create table ctphieunhap
(
    masp    varchar(4),
    sopn    varchar(5),
    soluong smallint not null default 0,
    gianhap real     not null check ( gianhap >= 0 ),
    primary key (masp, sopn)
);
create table phieuxuat
(
    sopx    varchar(5) primary key,
    manv    varchar(4) not null,
    makh    varchar(4) not null,
    ngayban datetime   not null,
    ghichu  text
);

create table ctphieuxuat
(
    masp    varchar(4),
    sopx    varchar(5),
    soluong smallint not null check ( soluong > 0 ),
    giaban  real     not null check ( giaban > 0 ),
    primary key (masp, sopx)
);

# trigger
# ref

alter table phieunhap
    add foreign key (manv) references nhanvien (manv),
    add foreign key (mancc) references nhacungcap (mancc);

alter table ctphieunhap
    add foreign key (masp) references sanpham (masp),
    add foreign key (sopn) references phieunhap (sopn);

alter table phieuxuat
    add foreign key (manv) references nhanvien (manv),
    add foreign key (makh) references khachhang (makh);


alter table ctphieuxuat
    add foreign key (masp) references sanpham (masp),
    add foreign key (sopx) references phieuxuat (sopx);

alter table sanpham
    add foreign key (maloaisp) references loaisp (maloaisp);

create trigger trigger_fk_ngayban
    before insert
    on phieuxuat
    for each row
begin
    if NEW.ngayban <= curdate()
        then
        signal sqlstate '45000' set message_text ='ngay ban ko the be hơn hoac bang ngay hien tai';
    end if;
end;







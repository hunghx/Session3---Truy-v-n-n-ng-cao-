create database tonghop2_quanlykhachang;
use tonghop2_quanlykhachang;
create table KhachHang
(
    maKh     varchar(4) primary key not null,
    tenKh    varchar(30)            not null,
    diachi   varchar(50),
    ngaysinh datetime,
    sodt     varchar(15) unique
);
create table NhanVien
(
    manv       varchar(4)  not null primary key,
    hoten      varchar(30) not null,
    gioitinh   bit         not null,
    diachi     varchar(50) not null,
    ngaysinh   datetime    not null,
    dienthoai  varchar(15),
    email      text,
    noisinh    varchar(20) not null,
    ngayvaolam datetime,
    maNQL      varchar(4)  not null
);
create table NhaCungCap
(
    maNCC     varchar(5)  not null primary key,
    tenNcc    varchar(50) not null,
    diachi    varchar(50) not null,
    dienthoai varchar(15) not null,
    email     varchar(30) not null,
    website   varchar(30)
);
create table LoaiSP
(
    maloaiSP  varchar(4)   not null primary key,
    tenloaiSP varchar(30)  not null,
    ghichu    varchar(100) not null
);
create table SanPham
(
    maSP      varchar(4)  not null primary key,
    maloaiSP  varchar(4)  not null,
    tenSP     varchar(50) not null,
    donvitinh varchar(10) not null,
    ghichu    varchar(100)
);
create table PhieuNhap
(
    soPN     varchar(5) not null primary key,
    maNV     varchar(4) not null,
    maNCC    varchar(5) not null,
    ngaynhap datetime   not null,
    ghichu   varchar(100)
);
create table CtPhieuNhap
(
    maSP    varchar(4) not null,
    soPN    varchar(5) not null,
    primary key (maSP, soPN),
    soluong smallint   not null default (0),
    gianhap decimal    not null check ( gianhap >= 0 )
);
create table PhieuXuat
(
    soPX    varchar(5) not null primary key,
    maNv    varchar(4) not null,
    maKh    varchar(4) not null,
    ngayban datetime   not null,
    ghichu  text
);
create table CtPhieuXuat
(
    soPX    varchar(5),
    maSP    varchar(4),
    primary key (soPX, maSP),
    soluong smallint not null,
    giaban  decimal  not null check ( giaban > 0 )
);
#Bài 2: Dùng câu lệnh ALTER để thêm rằng buộc khóa ngoại cho các bảng
alter table PhieuNhap
    add foreign key (maNCC) references NhaCungCap (maNCC),
    add foreign key (maNV) references NhanVien (manv);

alter table CtPhieuNhap
    add foreign key (soPN) references PhieuNhap (soPN),
    add foreign key (maSP) references SanPham (maSP);

alter table SanPham
    add foreign key (maloaiSP) references LoaiSP (maloaiSP);

alter table CtPhieuXuat
    add foreign key (maSP) references SanPham (maSP),
    add foreign key (soPX) references PhieuXuat (soPX);

alter table PhieuXuat
    add foreign key (maKh) references KhachHang (maKh);
alter table PhieuNhap
    modify ngaynhap date;
alter table NhanVien
    modify ngaysinh date;

#Bài 3: Dùng lệnh INSERT thêm dữ liệu vào các bảng:
# 1. Thêm 2 Phiếu nhập trong tháng hiện hành. Mỗi phiếu nhập có 2 sản phẩm.
# (Tùy chọn các thông tin liên quan còn lại)
# 2. Thêm 2 Phiếu xuất trong ngày hiện hành. Mỗi phiếu xuất có 3 sản phẩm.
# (Tùy chọn các thông tin liên quan còn lại)
# 3. Thêm 1 nhân viên mới (Tùy chọn các thông tin liên quan còn lại)

#Yêu cầu 1 phải thêm dữ liệu vào nhiều bảng khác vì có liên kết với nhau
insert into NhaCungCap (maNCC, tenNcc, diachi, dienthoai, email, website)
VALUES ('NCC01', 'nhacungcap1', 'diachi1', 'dienthoai1', 'email1', 'website1'),
       ('NCC02', 'nhacungcap2', 'diachi2', 'dienthoai2', 'email2', 'website2');
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV01', 'nhanvien1', 1, 'diachinhanvien1', '1994-10-10', '0987654321', 'emailnhanvien1', 'hanoi', curdate(),
        'NQL1'),
       ('NV02', 'nhanvien2', 0, 'diachinhanvien2', '1995-11-21', '0987654312', 'emailnhanvien2', 'hanoi', curdate(),
        'NQL2');

insert into LoaiSP (maloaiSP, tenloaiSP, ghichu)
VALUES ('lsp1', 'giay', 'ghichuloaisanpham1');
insert into SanPham (maSP, maloaiSP, tenSP, donvitinh, ghichu)
VALUES ('SP01', 'lsp1', 'tensanpham1', 'chai', 'ghichusanpham1'),
       ('SP02', 'lsp1', 'tensanpham2', 'chai', 'ghichusanpham2'),
       ('SP03', 'lsp1', 'tensanpham3', 'chai', 'ghichusanpham3'),
       ('SP04', 'lsp1', 'tensanpham4', 'chai', 'ghichusanpham4');

insert into PhieuNhap (soPN, maNV, maNCC, ngaynhap, ghichu)
VALUES ('PN001', 'NV01', 'NCC01', current_date, 'ghichuphieunhap1'),
       ('PN002', 'NV02', 'NCC02', current_date, 'ghichuphieunhap2');
insert into CtPhieuNhap (maSP, soPN, soluong, gianhap)
VALUES ('SP01', 'PN001', 2, 2.5),
       ('SP02', 'PN001', 5, 4.5),
       ('SP03', 'PN002', 3, 3.4),
       ('SP04', 'PN002', 4, 1.635);

#Yêu cầu 2
insert into KhachHang (maKh, tenKh, diachi, ngaysinh, sodt)
VALUES ('kh01', 'khachang1', 'diachikhach1', '1990-12-20', '0987654123'),
       ('kh02', 'khachhang2', 'diachikhach2', '1989-1-2', '0987654132');
insert into PhieuXuat (soPX, maNv, maKh, ngayban, ghichu)
VALUES ('PX001', 'NV01', 'KH01', curdate(), 'ghichuphieuxuat1'),
       ('px002', 'nv02', 'kH02', CURRENT_DATE, 'ghichuphieuxuat2');
insert into CtPhieuXuat (soPX, maSP, soluong, giaban)
VALUES ('px001', 'sp01', 3, 2.55),
       ('px001', 'sp02', 4, 3.55),
       ('px001', 'sp03', 5, 4.56),
       ('px002', 'sp02', 1, 10.55),
       ('px002', 'sp03', 6, 1.55),
       ('px002', 'sp04', 4, 7.2);
#Yêu cầu 3
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV03', 'nhanvien3', 1, 'diachinhanvien3', '1994-10-10', '0987654321', 'emailnhanvien3', 'hanoi', curdate(),
        'NQL1');

# Bài 4: Dùng lệnh UPDATE cập nhật dữ liệu các bảng
# 1. Cập nhật lại số điện thoại mới cho khách hàng mã KH10. (Tùy chọn các
# thông tin liên quan)
# 2. Cập nhật lại địa chỉ mới của nhân viên mã NV05 (Tùy chọn các thông tin
# liên quan)
update KhachHang
set sodt = 'sodienthoaimoi'
where maKh = 'kh01';
update NhanVien
set diachi = 'diachimoi'
where manv = 'nv02';
# Bài 5: Dùng lệnh DELETE xóa dữ liệu các bảng
#                      1. Xóa nhân viên mới vừa thêm tại yêu cầu C.3
#                      2. Xóa sản phẩm mã SP15
delete
from NhanVien
where manv = 'nv03';
insert into SanPham (maSP, maloaiSP, tenSP, donvitinh, ghichu)
VALUES ('SP05', 'lsp1', 'sanphambixoa', 'cai', 'ghichuxoa');
delete
from SanPham
where maSP = 'Sp05';
# Bài 6: Dùng lệnh SELECT lấy dữ liệu từ các bảng
# 1. Liệt kê thông tin về nhân viên trong cửa hàng, gồm: mã nhân viên, họ tên
# nhân viên, giới tính, ngày sinh, địa chỉ, số điện thoại, tuổi. Kết quả sắp xếp
# theo tuổi.
select manv, hoten, NhanVien.gioitinh, NhanVien.ngaysinh, NhanVien.diachi, NhanVien.dienthoai, NhanVien.ngaysinh
from NhanVien
order by (current_date - NhanVien.ngaysinh) desc;
# 2. Liệt kê các hóa đơn nhập hàng trong tháng 6/2018, gồm thông tin số phiếu
# nhập, mã nhân viên nhập hàng, họ tên nhân viên, họ tên nhà cung cấp, ngày
# nhập hàng, ghi chú.
select PhieuNhap.soPN, PhieuNhap.maNV, NhanVien.hoten, NCC.tenNcc, PhieuNhap.ngaynhap, PhieuNhap.ghichu
from phieunhap as PhieuNhap
         join Nhanvien as NhanVien on PhieuNhap.maNV = NhanVien.manv
         join NhaCungCap as NCC on PhieuNhap.maNCC = NCC.maNCC;
# 3. Liệt kê tất cả sản phẩm có đơn vị tính là chai, gồm tất cả thông tin về sản
# phẩm.
select *
from SanPham
where donvitinh = 'chai';
# 4. Liệt kê chi tiết nhập hàng trong tháng hiện hành gồm thông tin: số phiếu
# nhập, mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính, số lượng, giá
# nhập, thành tiền.
select pn.soPN,
       ct.maSP,
       tenSP,
       maloaiSP,
       donvitinh,
       soluong,
       gianhap,
       (soluong * gianhap) as thanhtien
from phieunhap as pn
         join ctphieunhap as ct on ct.soPN = pn.soPN
         join sanpham as sp on ct.maSP = sp.maSP;
# 5. Liệt kê các nhà cung cấp có giao dịch mua bán trong tháng hiện hành, gồm
# thông tin: mã nhà cung cấp, họ tên nhà cung cấp, địa chỉ, số điện thoại,
# email, số phiếu nhập, ngày nhập. Sắp xếp thứ tự theo ngày nhập hàng.
select ncc.maNCC, ncc.tenNcc, ncc.diachi, ncc.dienthoai, ncc.email, pn.soPN, pn.ngaynhap
from NhaCungCap ncc
         join phieunhap as pn
where month(pn.ngaynhap) = month(current_date)
order by pn.ngaynhap;
# 6. Liệt kê chi tiết hóa đơn bán hàng trong 6 tháng đầu năm 2018 gồm thông tin:
# số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm,
# đơn vị tính, số lượng, giá bán, doanh thu.
select px.soPX,
       nv.hoten,
       px.ngayban,
       sp.maSP,
       sp.tenSP,
       sp.donvitinh,
       cpx.soluong,
       cpx.giaban,
       cpx.soluong * cpx.giaban as doanhthu
from phieuxuat px
         join nhanvien nv on px.maNv = nv.manv
         join ctphieuxuat cpx on cpx.soPX = px.soPX
         join sanpham sp on sp.maSP = cpx.maSP;
# 7. Hãy in danh sách khách hàng có ngày sinh nhật trong tháng hiện hành (gồm
# tất cả thông tin của khách hàng)
select *
from khachhang kh
#Vì ngaysinh của khách hàng là dạng datetime => Cần chuyển về date trước rồi mới month
where month(date(kh.ngaysinh)) = month(curdate());
# 8. Liệt kê các hóa đơn bán hàng từ ngày 15/04/2018 đến 15/05/2018 gồm các
# thông tin: số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên
# sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu
insert
into PhieuXuat (soPX, maNv, maKh, ngayban, ghichu)
VALUES ('PX003', 'NV01', 'KH01', '2018-04-30', 'ghichuphieuxuat1'),
       ('px004', 'nv02', 'kH02', '2018-05-14', 'ghichuphieuxuat2');
insert into CtPhieuXuat (soPX, maSP, soluong, giaban)
VALUES ('px003', 'sp02', 3, 2.55),
       ('px003', 'sp01', 4, 3.55),
       ('px003', 'sp04', 5, 4.56),
       ('px004', 'sp01', 1, 10.55),
       ('px004', 'sp04', 6, 1.55),
       ('px004', 'sp02', 4, 7.2);
select px.soPX,
       px.maNv,
       px.ngayban,
       CPX.maSP,
       sp.tenSP,
       sp.donvitinh,
       CPX.soluong,
       CPX.giaban,
       (CPX.soluong * CPX.giaban) as doanhthu
from PhieuXuat px
         join CtPhieuXuat CPX on px.soPX = CPX.soPX
         join SanPham SP on CPX.maSP = SP.maSP
where px.ngayban >= date('2018-04-15')
  and px.ngayban <= date('2018-05-15');
# 9. Liệt kê các hóa đơn mua hàng theo từng khách hàng, gồm các thông tin: số
# phiếu xuất, ngày bán, mã khách hàng, tên khách hàng, trị giá.
select px.soPX,
       px.ngayban,
       px.maKh,
       kh.tenKh,
       sum(cpx.giaban * cpx.soluong) as trigia
from PhieuXuat px
         join KhachHang KH on px.maKh = KH.maKh
#Số PX khác nhau nên phải join theo số PX chứ không join được theo khách hàng
         join ctphieuxuat cpx on cpx.soPX = px.soPX
group by px.soPX, kh.maKh
order by kh.maKh;
# 10. Cho biết tổng số chai nước xả vải Comfort đã bán trong 6 tháng đầu năm
# 2018. Thông tin hiển thị: tổng số lượng.
insert into LoaiSP (maloaiSP, tenloaiSP, ghichu)
VALUES ('lsp2', 'comfort', 'ghichucomfort');
insert into SanPham (maSP, maloaiSP, tenSP, donvitinh, ghichu)
VALUES ('SP05', 'lsp2', 'nuocxavai', 'chai', 'ghichunuocxavai');
insert into PhieuXuat (soPX, maNv, maKh, ngayban, ghichu)
VALUES ('PX005', 'NV01', 'KH01', '2018-04-30', 'ghichuphieuxuat1'),
       ('px006', 'nv02', 'kH02', '2018-07-28', 'ghichuphieuxuat2');
insert into CtPhieuXuat (soPX, maSP, soluong, giaban)
VALUES ('px005', 'sp05', 3, 2.55),
       ('px006', 'sp05', 4, 7.2);
select cpx.soluong as Tongsoluong
from ctphieuxuat cpx
         join phieuxuat px on px.soPX = cpx.soPX
where px.ngayban <= date('2018-06-30')
  and cpx.maSP = 'sp05';
# 11.Tổng kết doanh thu theo từng khách hàng theo tháng, gồm các thông tin:
# tháng, mã khách hàng, tên khách hàng, địa chỉ, tổng tiền.
select month(px.ngayban)             as 'Month',
       kh.maKh,
       kh.tenKh,
       kh.diachi,
       sum(cpx.soluong * cpx.giaban) as 'Total revenue'
from khachhang kh
         join phieuxuat px on px.maKh = kh.maKh
         join ctphieuxuat cpx on px.soPX = cpx.soPX
#Group by month => Trong tháng 4 có 2 mã khách hàng khác nhau
#=> Phải tiếp tục group by makh để subdivide tiếp thì mới không lỗi
group by month(px.ngayban), kh.maKh;
# 12.Thống kê tổng số lượng sản phẩm đã bán theo từng tháng trong năm, gồm
# thông tin: năm, tháng, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số
# lượng.
select year(px.ngayban) as 'Year',
       month(px.ngayban)   'Month',
       sp.maSP,
       sp.tenSP,
       sp.donvitinh,
       sum(cpx.soluong)    'Tong so'
from SanPham sp
         join phieuxuat px
         join ctphieuxuat cpx on cpx.maSP = sp.maSP
group by year(px.ngayban), month(px.ngayban), sp.maSP;
# 13.Thống kê doanh thu bán hàng trong trong 6 tháng đầu năm 2018, thông tin
# hiển thị gồm: tháng, doanh thu
select year(px.ngayban) as nam, month(px.ngayban) as thang, sum(cpx.soluong * cpx.giaban) as doanhthu
from ctphieuxuat cpx
         join phieuxuat px on cpx.soPX = px.soPX
where date(px.ngayban) <= date('2018-06-30')
group by nam, thang;
# 14.Liệt kê các hóa đơn bán hàng của tháng 5 và tháng 6 năm 2018, gồm các
# thông tin: số phiếu, ngày bán, họ tên nhân viên bán hàng, họ tên khách hàng,
# tổng trị giá.
select px.soPX, px.ngayban, nv.hoten, kh.tenKh, sum(cpx.soluong * cpx.giaban) as 'Tong tri gia'
from phieuxuat px
         join khachhang kh on px.maKh = kh.maKh
         join nhanvien nv on px.maNv = nv.manv
         join ctphieuxuat cpx on cpx.soPX = px.soPX
where year(px.ngayban) = 2018
  and (month(px.ngayban) = 5 or month(px.ngayban) = 6)
group by year(px.ngayban), month(px.ngayban), px.soPX;
# 15.Cuối ngày, nhân viên tổng kết các hóa đơn bán hàng trong ngày, thông tin
# gồm: số phiếu xuất, mã khách hàng, tên khách hàng, họ tên nhân viên bán
# hàng, ngày bán, trị giá.
select px.soPX, kh.maKh, kh.tenKh, nv.hoten, px.ngayban, sum(cpx.giaban * cpx.soluong)
from phieuxuat px
         join khachhang kh on px.maKh = kh.maKh
         join ctphieuxuat cpx on cpx.soPX = px.soPX
         join nhanvien nv on nv.manv = px.maNv
where px.ngayban = current_date
group by px.soPX;
# 16.Thống kê doanh số bán hàng theo từng nhân viên, gồm thông tin: mã nhân
# viên, họ tên nhân viên, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số
# lượng.
select nv.manv, nv.hoten, sp.maSP, sp.tenSP, sp.donvitinh, sum(cpx.soluong)
from NhanVien nv
         join phieuxuat px on nv.manv = px.maNv
         join ctphieuxuat cpx on cpx.soPX = px.soPX
         join sanpham sp on sp.maSP = cpx.maSP
group by nv.manv, sp.maSP
order by nv.manv;
# 17.Liệt kê các hóa đơn bán hàng cho khách vãng lai (KH01) trong quý 2/2018,
# thông tin gồm số phiếu xuất, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị
# tính, số lượng, đơn giá, thành tiền.
select px.soPX,
       px.ngayban,
       sp.maSP,
       sp.tenSP,
       sp.donvitinh,
       sum(cpx.soluong)              as 'So luong',
       cpx.giaban,
       sum(cpx.soluong * cpx.giaban) as 'Thanh tien'
from phieuxuat px
         join ctphieuxuat cpx on px.soPX = cpx.soPX
         join sanpham sp on cpx.maSP = sp.maSP
         join khachhang kh on kh.maKh = px.maKh
where kh.maKh = 'kh01'
  and px.ngayban >= '2018-4-1'
  and px.ngayban <= '2018-6-30'
group by px.soPX, sp.maSP;
# 18.Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018, thông tin
# gồm: mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
select sp.maSP, sp.tenSP, LoaiSP.tenloaiSP, sp.donvitinh, px.ngayban
from sanpham sp
         join loaisp on sp.maloaiSP = LoaiSP.maloaiSP
         join ctphieuxuat cpx on cpx.maSP = sp.maSP
         join phieuxuat px on px.soPX = cpx.soPX
where not (date(px.ngayban) >= date('2018-01-01')
    and date(px.ngayban) <= date('2018-06-30'))
group by sp.maSP, LoaiSP.tenloaiSP, px.ngayban;
# 19.Liệt kê danh sách nhà cung cấp không giao dịch mua bán với cửa hàng trong
# quý 2/2018, gồm thông tin: mã nhà cung cấp, tên nhà cung cấp, địa chỉ, số
# điện thoại.
insert into nhacungcap (maNCC, tenNcc, diachi, dienthoai, email, website)
VALUES ('NCC03', 'Nhacungcap3', 'diachi3', 'dienthoai3', 'email3', 'website3');
select ncc.maNCC, ncc.tenNcc, ncc.diachi, ncc.dienthoai
from nhacungcap ncc
         left join phieunhap pn on pn.maNCC = ncc.maNCC
#Ngày nhập không nằm trong khoảng quý 2 thì là không có giao dịch mua bán
where (not date(pn.ngaynhap) <= '2018-6-30'
    and date(pn.ngaynhap) >= '2018-4-1')
#Mã nhà cung cấp không trùng với bất kì mã nào của phiếu nhập => Chưa từng có giao dịch
   or (ncc.maNCC not in (select PhieuNhap.maNCC from phieunhap));
# 20.Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong 6 tháng đầu năm
# 2018.
select kh.tenKh, max(cpx.soluong * cpx.giaban) as maxPurchase
from KhachHang kh
         join PhieuXuat PX on kh.maKh = PX.maKh
         join ctphieuxuat cpx on cpx.soPX = px.soPX
#Điều kiện về thời gian mua hàng
where date(px.ngayban) >= '2018-1-1'
  and date(px.ngayban) <= '2018-6-30'
#Vì có max nên cần group by. Sắp xếp theo thứ tự giảm dần của giá trị hàng hóa
#limit 1 sẽ là khách hàng đầu tiên có đơn mua cao nhất
group by kh.tenKh
order by maxPurchase desc
limit 1;
# 21.Cho biết mã khách hàng và số lượng đơn đặt hàng của mỗi khách hàng.
select px.maKh, count(px.maKh)
from phieuxuat px
group by px.maKh;
# 22.Cho biết mã nhân viên, tên nhân viên, tên khách hàng kể cả những nhân viên
# không đại diện bán hàng.
# Không có cách tránh sự lặp lại họ tên mã nhân viên vì duyệt nhiều lần??
select distinct nv.manv, nv.hoten, kh.tenKh
from nhanvien nv
         join khachhang kh;
# 23.Cho biết số lượng nhân viên nam, số lượng nhân viên nữ
select count(case nv.gioitinh when 1 then 1 end) as nam, count(case nv.gioitinh when 0 then 1 end) as nu
from nhanvien nv;
#Cách 2 join 2 lần chọn lại thành một bảng mới => mỗi lần chọn là 1 cột trong bảng
#Không đặt được alias cho virtual table sau câu lệnh from??
select countnam, countnu
from ((select count(nv.gioitinh) as countnam from nhanvien nv where nv.gioitinh = 1)
    as nam join (select count(nv.gioitinh) as countnu from nhanvien nv where nv.gioitinh = 0) as nu);
#Cách 3
select case nv.gioitinh
           when 1 then 'nam'
           when 0 then 'nu'
           end as gioitinh,
       count(nv.gioitinh)
from nhanvien nv
group by nv.gioitinh;
# 24.Cho biết mã nhân viên, tên nhân viên, số năm làm việc của những nhân viên
# có thâm niên cao nhất.
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV04', 'nhanvien4', 1, 'diachinhanvien4', '1994-10-10', '0987654321', 'emailnhanvien4', 'hanoi', '2018-11-1',
        'NQL1');
#Có thể dùng order by + limit để tìm ra nhân viên lâu nhất
select nv.manv, nv.hoten, max(timediff(year(current_date), year(nv.ngayvaolam)))
from nhanvien nv
group by manv;
# 25.Hãy cho biết họ tên của những nhân viên đã đến tuổi về hưu (nam:60 tuổi,
# nữ: 55 tuổi)
insert into nhanvien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV10', 'nhanvienvehuu', 1, 'diachi', '1950-1-1', 'dienthoai', 'email', 'noisinh', '2022-2-2', 'NQL1');
select nv.hoten,
       case nv.gioitinh
           when 1 then 'nam'
           when 0 then 'nu'
           end                             as gioitinh,
       year(curdate()) - year(nv.ngaysinh) as tuoinhanvien
from nhanvien nv
where (case
           when nv.gioitinh = 1 then year(curdate()) - year(nv.ngaysinh) >= 60
           else
               year(curdate()) - year(nv.ngaysinh) >= 55 end);
# 26.Hãy cho biết họ tên của nhân viên và năm về hưu của họ.
select nv.hoten,
       (case
            when nv.gioitinh = 1 then year(date_add(nv.ngaysinh, interval 60 year))
            else
                year(date_add(nv.ngaysinh, interval 55 year))
           end) as namvehuu
from nhanvien nv;
# 27.Cho biết tiền thưởng tết dương lịch của từng nhân viên. Biết rằng - thâm
# niên <1 năm thưởng 200.000 - 1 năm <= thâm niên < 3 năm thưởng
# 400.000 - 3 năm <= thâm niên < 5 năm thưởng 600.000 - 5 năm <= thâm
# niên < 10 năm thưởng 800.000 - thâm niên >= 10 năm thưởng 1.000.000
select nv.hoten,
       case
           when year(now()) - year(nv.ngayvaolam) < 1 then '200k'
           when year(now()) - year(nv.ngayvaolam) >= 1 and year(now()) - year(nv.ngayvaolam) < 3 then '400k'
           when year(now()) - year(nv.ngayvaolam) >= 3 and year(now()) - year(nv.ngayvaolam) < 5 then '600k'
           when year(now()) - year(nv.ngayvaolam) >= 5 and year(now()) - year(nv.ngayvaolam) < 10 then '800k'
           when year(now()) - year(nv.ngayvaolam) >= 10 then '1000k'
           end as thuong
from nhanvien nv;

# 28.Cho biết những sản phẩm thuộc ngành hàng Hóa mỹ phẩm
select sp.tenSP
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Mỹ phẩm';
# 29.Cho biết những sản phẩm thuộc loại Quần áo.
select sp.tenSP
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Quần áo';
# 30.Cho biết số lượng sản phẩm loại Quần áo.
select sp.tenSP, count(sp.maloaiSP)
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Quần áo'
group by sp.tenSP;
# 31.Cho biết số lượng loại sản phẩm ngành hàng Hóa mỹ phẩm.
select sp.tenSP, count(sp.maloaiSP)
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Mỹ phẩm'
group by sp.tenSP;
# 32.Cho biết số lượng sản phẩm theo từng loại sản phẩm.
select sp.tenSP, count(sp.maloaiSP)
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
group by sp.tenSP;

# 1. Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh
# viên, Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã
# sinh viên tăng dần
select MaSV `Mã sinh viên`, HoSV `Họ sinh viên`, TenSV `Tên sinh viên`, HocBong `học bổng`
from dmsv
order by MaSV;
# 2. Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên,
# Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
select MaSV `Mã sinh viên`, concat(HoSV, ' ', TenSV) `Họ tên sinh viên`, Phai `Giới tinh`, NgaySinh
from dmsv
order by Phai, TenSV;

# 3. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông
# tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
select concat(HoSV, ' ', TenSV) `Họ tên sinh viên`, NgaySinh, HocBong
from dmsv
order by NgaySinh, HocBong desc;

# 4. Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: Mã
# môn, Tên môn, Số tiết.

select MaMH, TenMH, SoTiet
from dmmh
where TenMH like 'T%';

# 5. Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là I, gồm
# các thông tin: Họ tên sinh viên, Ngày sinh, Phái.

select concat(HoSV, ' ', TenSV) `Họ tên sinh viên`, NgaySinh, Phai
from dmsv
where TenSV like '%I';
# 18. Danh sách những sinh viên có tuổi từ 20 đến 25, thông tin gồm: Họ tên sinh
# viên, Tuổi, Tên khoa.

select concat(HoSV, ' ', TenSV) `Họ tên sinh viên`, year(curdate()) - year(dmsv.NgaySinh) `Tuoi`, dmkhoa.TenKhoa
from dmsv
         join dmkhoa
              on dmsv.MaKhoa = dmkhoa.MaKhoa
where year(curdate()) - year(dmsv.NgaySinh) between 20 and 40;
# 24. Cho biết số lượng sinh viên học từng môn.

select dmmh.TenMH, count(k.MaSV)
from ketqua k
         join dmmh on k.MaMH = dmmh.MaMH
group by dmmh.MaMH
having count(k.MaSV) >= 5;
;
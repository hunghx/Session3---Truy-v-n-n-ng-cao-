# Hàm tổ hợp : SUM, MAX, MIN, AVG, COUNT ;
select * from world.city;
select COUNT(*) from world.city; -- tất cả bản ghi (null cũng đếm) = 4079
select count(distinct countryCode) from world.city;

# Hàm sum

select CountryCode,SUM(Population) from world.city
group by CountryCode;
select SUM(Population) from world.country;
# Hàm AVG
select AVG(Population) from world.city;

#Max|Min
select max(Population) from world.country;

explain analyze select * from world.country where Population = (select max(Population) from world.country);
explain analyze select * from world.country order by Population desc limit 1;

# explain analyze select * from world.country where Population >= ALL (select Population from world.country);
# Hàm thao tác dữ liệu :UCASE, LOWCASE, LENGTH, CONCAT, FORMAT, YEAR, MONTH, DATE, YEARWEEK
# curdate(), current_time() , now()


# cú phap case ... when
# <=1000000 , ít dân
# <=10000000 , bình thường
# >10000000, đông dân


select tk.level, count(*) `số lượng` from (select Name , case when Population <= 1000000 then 'Ít dân'
                    when Population <= 10000000 then 'Bình thường'
                        else 'Đông dân'
                            end
    level from world.country) as tk
group by tk.level;

# Toán tử 3 ngôi
select TenSV, IF(Phai = 'Nam',1,0)
from quanlydiemsv.dmsv;

# Phủ đinh mệnh đề
    # hãy thống kê nhwungx thành phố ko có trong qốc qua nào
    # thống kê những quốc qua ko có thành phố
    select count(Distinct Code) from world.country;

# thống kê những quốc qua ko có thành phố

select * from world.country where code not in (select distinct CountryCode from world.city);

# hay thống kê những san pham ko dươc ban trong thang
use  tonghop2_quanlykhachang;
select * from sanpham where masp not in (select distinct masp from ctphieuxuat ct join phieuxuat px
            on ct.soPX = px.soPX
            where  (month(px.ngayban) = month(curdate())
              and year(px.ngayban) = year(curdate())));

# ALL, ANY, EXIST
# lấy ra danh sách người mua có hóa hơn hớn hơn bất kì
# hóa đơn nào của khách hàng số 01
select distinct maKh,sum(ct.soluong*ct.giaban) from phieuxuat px join ctphieuxuat ct
                                                        on px.soPX = ct.soPX
group by px.soPX
having sum(ct.soluong*ct.giaban) > ALL (select distinct sum(ct.soluong*ct.giaban) from phieuxuat px join ctphieuxuat ct
                                                                                                 on px.soPX = ct.soPX
                                         where px.maKh like 'kh01'
                                         group by px.soPX
)
;

#UNION
# cross join / full outer join
use  world;
select * from country left join city on country.Code = city.CountryCode
union
select * from country right join city on country.Code = city.CountryCode;


select maSV, tenSv, phai, ngaysinh,noisinh from quanlydiemsv.dmsv where phai like 'Nam'
union
select * from world.city;

use tonghop2_quanlykhachang;










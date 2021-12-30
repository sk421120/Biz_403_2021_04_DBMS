-- % : 어디에서나 접근가능
CREATE USER 'node'@'%'
identified by '12341234';

-- 모든 권한 부여
GRANT ALL PRIVILEGES ON *.* TO 'node'@'%';

CREATE DATABASE nodeDB;

use nodeDB;

DESC tbl_bbs;

drop table tbl_bbs;

select * from tbl_bbs;

drop table tbl_orders;

drop table tbl_table_orders;

Insert into tbl_products(p_code, p_name, p_price)
values
('P0001', '로제 떡볶이', 2500),
('P0002', '로제 닭볶이', 7000),
('P0003', '로제 피자', 5000),
('P0004', '로제 파스타', 5500),
('P0005', '로제 리조또', 4500),
('P0006', '로제 찜닭', 8500),
('P0007', '로제 타코', 2000),
('P0008', '크림 떡볶이', 3000),
('P0009', '사이다', 1000),
('P0010', '콜라', 1000);
-- 관리자
CREATE database oneday_score;

use mysql;

create user onescore@localhost;
create user onescore@'192.168.0.%';

show grants for onescore@localhost;
show grants for onescore@'192.168.0.%';

GRANT all privileges on *.* TO onescore@localhost;
GRANT all privileges on *.* TO onescore@'192.168.0.%';

ALTER USER onescore@localhost
identified WITH mysql_native_password BY '12345';

ALTER USER onescore@'192.168.0.%'
identified WITH mysql_native_password BY '12345';

flush privileges;

SELECT * FROM USER WHERE User='onescore';
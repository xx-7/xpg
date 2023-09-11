
# Installation

```bash
sudo apt install mariadb-server
sudo mysql_secure_installation
sudo systemctl disable mariadb
sudo systemctl restart mariadb

```
# client

```bash

# 建库
create DATABASE $name CHARACTER SET utf8 COLLATE utf8_general_ci;

#删库
DROP DATABASE IF EXISTS x2cerdofus;

# 导入
mysqldump -u用户名 -p密码 -h主机 数据库 < 路径 #导入
# 导出
mysqldump -u用户名 -p密码 -h主机 数据库 > 路径
\. /path/file.sql

# $DB: 数据库名, *通配符
# $TABLE: 表名, *通配符
# $USER: 用户名 
# $HOST: 指定允许连接主机, %通配符 
# $PASS: 密码
# $PRIVILEGES: ALL/SELECT/INSERT/UPDATE/DELETE/CREATE/DROP/INDEX  多个,连接

# 添加用户 
CREATE USER '$USER'@'$HOST' IDENTIFIED BY '$PASS';

CREATE USER 'top'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'top'@'10.8.8.1' IDENDIFIED BY '123456';
CREATE USER 'top'@'%' IDENTIFIED BY '123456';
CREATE USER 'top'@'%' IDENTIFIED BY '';
CREATE USER 'top'@'%';

# 授权
GRANT $PRIVILEGES ON $DB.$TABLE TO '$USER'@'HOST';

GRANT SELECT,INSERT ON demo.user TO 'top'@'%';
GRANT ALL ON *.* TO 'top'@'%';
GRANT ALL ON demo.* TO 'top'@'%';

# 刷新权限
FLUSH PRIVILEGES;

# 改密
ALTER USER $USER IDENTIFIED BY '$PASS';

ALTER USER top IDENTIFIED BY '111111';

# 删除用户
DROP USER '$USER'@'$HOST';

DROP USER ‘top’@'%'
DROP USER ‘top’@'127.0.0.1'

# 撤销权限
# 注意： $PRIVILEGES $DB $TABLE 要跟GRANT设置权限时相同, 否则可能失效
REVOKE $PRIVILEGES ON $DB.$TABLE FROM '$USER'@'HOST';

REVOKE SELECT ON *.* FROM 'top'@'%';
REVOKE ALL ON *.* FROM 'top'@'127.0.0.1';

```
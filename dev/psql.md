# Install

```bash
# https://www.postgresql.org/download/linux/debian/

sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

sudo apt update

sudo apt -y install postgresql postgresql-client

sudo systemctl restart postgresql

sudo systemctl status postgresql

ps -ef | grep postgresql

sudo chmod 700 /optd/opt/pgsql/ 
sudo chown postgres.postgres /optd/opt/pgsql/

# 初始化
sudo -u postgres /usr/lib/postgresql/16/bin/initdb -D /optd/opt/pgsql/data --locale en_US.UTF-8 --auth md5 --pwprompt

# 创建节点
sudo pg_createcluster 16 main --start

sudo -u postgres /usr/lib/postgresql/16/bin/pg_ctl -D /optd/opt/pgsql/data -l logfile start

# 显示节点
pg_lsclusters

# 启动节点
sudo pg_ctlcluster 16 main start

sudo -u postgres psql

SHOW all;

```

# Use

```bash
# 显示所有库
\l

# 切换库
\c DBNAME

# 查所有表
\d
\dt

# 表结构
\d test

# 退出
\q

# 单个备份  格式 可以  bak(压缩) / sql (明文) / tar (加密)
pg_dump DB > db.bak

# 备份所有库
pg_dumpall > pg.bak

# 导出库
pg_dump -U postgres -f /tmp/pg.sql postgres

# 导出表
pg_dump -U postgres -f /tmp/pg.sql -t test postgres

# 恢复数据到 bk01 库
psql -U postgres -f /tmp/pg.sql bk01
pg_restore -U postgres -d bk01 /tmp/pg.tar

```

# 移动库数据位置

```bash
# 查询配置文件跟数据位置

sudo -u postgres psql

SHOW config_file;
SHOW data_directory;

sudo systemctl stop postgresql

sudo rsync -av /var/lib/postgresql/ /optd/opt/psql

sudo mv /var/lib/postgresql/16/main /var/lib/postgresql/16/main.bak

sudo nano /etc/postgresql/16/main/postgresql.conf
# 修改位置
data_directory = '/optd/opt/psql/16/main'

sudo rm -rf /var/lib/postgresql/16



```

# user

```bash

sudo -u postgres psql

# https://github.com/launchbadge/sqlx/blob/main/sqlx-postgres/src/types/mod.rs

# 显示用户列表
\du+

sudo -u postgres createuser --interactive --password testuser

CREATE DATABASE testdb;
CREATE USER testuser with password 'testuser';
GRANT ALL PRIVILEGES ON DATABASE testdb TO testuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO testuser;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO testuser;

# 转移授权
REASSIGN OWNED BY testuser TO dbuser;

# 删除前要先删除授权
DROP OWNED BY testuser;
DROP USER testuser;
DROP USER IF EXISTS testuser, testuser2;

# 改密
ALTER USER user_name WITH PASSWORD 'new_password';


# 生成十位随机字符
SELECT substring(md5(random()::varchar),3,10);
# 生成十位随机数字
SELECT substring(random()::varchar,3,10);
# uuid
SELECT uuid_in(md5(random()::text || now()::text)::cstring);
SELECT uuid_in(md5(random()::text || clock_timestamp()::text)::cstring);
SELECT md5(random()::text || clock_timestamp()::text)::uuid;

SELECT REPLACE(md5(random()::text || clock_timestamp()::text),'-','');

# uuid_generate_v1 自动生成

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

id uuid DEFAULT uuid_generate_v1() NOT NULL CONSTRAINT account_pkey PRIMARY KEY,

```

# 自动更新时间

```sql
BEGIN;
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
      NEW.updated_at = now(); 
      RETURN NEW;
END;
$$ language 'plpgsql';
COMMIT;


BEGIN;
CREATE TRIGGER user_timestamp BEFORE UPDATE ON account
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();
COMMIT;


```
```bash


# 查所有表
\d

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
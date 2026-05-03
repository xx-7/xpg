# 差异

- new-api支持模型多
- 支持plus登录直转

# sub2api

```bash
# https://github.com/Wei-Shaw/sub2api

# 数据库用的 postgresql, 缓存用的 redis 

# 临时启动
GIN_MODE=release SERVER_PORT=5443 ./sub2api

# 最终配置保存文件
nano config.yaml

# psql
CREATE DATABASE sub2apidb;
CREATE USER sub2api with password 'test123';

ALTER DATABASE sub2apidb OWNER TO sub2api;

GRANT ALL PRIVILEGES ON DATABASE sub2apidb TO sub2api;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sub2api;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sub2api;

# nginx 代理时配置
underscores_in_headers on;

# service
cat >> /usr/lib/systemd/system/sub2api.service << EOF
[Unit]
Description=sub2api
After=network.target postgresql.service redis-server.service
Wants=postgresql.service redis-server.service

[Service]
Type=simple
User=vm
WorkingDirectory=/zfs/opt/sub2api
ExecStart=/zfs/opt/sub2api/sub2api
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal
SyslogIdentifier=sub2api

# Security hardening
NoNewPrivileges=true
ProtectSystem=strict
ProtectHome=true
PrivateTmp=true

Environment=GIN_MODE=release
Environment=SERVER_HOST=127.0.0.1
Environment=SERVER_PORT=5442

[Install]
WantedBy=multi-user.target
EOF

```

# new-api

```bash
# https://github.com/QuantumNous/new-api
# https://docs.newapi.pro/en/docs/installation/config-maintenance/environment-variables
nano .env

PORT=5431
SQL_DSN=postgresql://newapi:test123@localhost:5432/newapidb

# psql
CREATE DATABASE newapidb;
CREATE USER newapi with password 'test123';

ALTER DATABASE newapidb OWNER TO newapi;

GRANT ALL PRIVILEGES ON DATABASE newapidb TO newapi;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO newapi;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO newapi;

# service

cat >> /usr/lib/systemd/system/new-api.service << EOF
[Unit]
Description=new-api

[Service]
User=vm
WorkingDirectory=/zfs/opt/new-api
ExecStart=/zfs/opt/new-api/new-api-v1.0.0-rc.2
EOF

```
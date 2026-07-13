

```bash

# 配置
rclone config

# 

nano ~/.config/rclone/rclone.conf

[cf]
type = s3
provider = Cloudflare
access_key_id = <YOUR_ACCESS_KEY_ID>
secret_access_key = <YOUR_SECRET_ACCESS_KEY>
endpoint = https://<ACCOUNT_ID>.r2.cloudflarestorage.com
region = auto
acl = private

# $TAG 为配置节点名称 $NAME 桶名称
# 复制默认会跳过大小和修改时间相同的

# 查询所有桶
rclone lsd TAG:

# 创建一个新的桶
rclone mkdir $TAG:$NAME

# 将文件复制到该存储桶中
rclone copy /path/to/files $TAG:$NAME

# 从该存储桶中复制文件
rclone copy $TAG:$NAME /tmp/bucket-copy

# 列出bucket中的所有文件
rclone ls $TAG:$NAME

# 首先尝试同步, 同步时会删除桶中重复, 先尝试 
rclone --dry-run sync /path/to/files $TAG:$NAME

# 同步, 同步时会删除桶中重复
rclone sync /path/to/files $TAG:$NAME

```
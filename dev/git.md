# 常用操作

```bash

git config --global user.name "zz"
git config --global user.email zz@zz.com

git config --global http.proxy 'socks5://127.0.0.1:11028'
git config --global https.proxy 'socks5://127.0.0.1:11028'

git config --global http.proxy 'http://127.0.0.1:11018'
git config --global https.proxy 'http://127.0.0.1:11018'

git config --global http.proxy 'socks5://172.17.0.1:11028'
git config --global https.proxy 'socks5://172.17.0.1:11028'

git config --global --unset http.proxy
git config --global --unset https.proxy

git config --global init.defaultBranch main

git add -A
git commit -m "test"

git commit -a -m 'test'

# 更新引用
git push -u origin main

# 查看状态
git status

# 新建分支
git checkout -b feature_b

# 添加子模块
git submodule add [url] [path]

# 添加子模块 指定分支
git submodule add -b [branchName] [url] [path]

git submodule init .\sub-1\
git submodule update .\sub-1\

# 手动拉子模块
git submodule update  --init .\sub-1\

# 拉取时同步拉子模块
git clone [主仓url] --recurse-submodules

# 切换分支
git checkout master

# 合并分支
git merge feature_b

# 删除分支
git branch -d feature_b

# 删除
git rm * -r

# 拉取更新
git pull

# 查看文件不同，可加文件路径
git diff

# 自动合并失败,手动合并
git mergetool

# 放弃本地修改强拉远程
git fetch origin
git reset --hard origin/master
git reset --hard origin/main

# --soft 删除改动文件, 撤消commit 撤消add
# --mixed 不删除改动文件, 撤消commit 撤消add
# --soft 不删除改动文件, 撤消commit 不撤消add
# HEAD^ 上次 HEAD~2 上两次commit

# 回到某次提交
git log
git reset --hard $COMMIT

# 撤消最后一次提交
git reset --mixed HEAD^

# 推送已经创建
git remote add origin https://test.com/test/test.git

# 切换验证方式
git remote -v
git remote rm origin
git remote add origin git@github.com:USER/PROJECT.git
```

```bash
git branch              # 查看分支
git branch -r           # 查看远程分支
git branch dev          # 创建dev分支
git branch -m old new  # 改分支名
git branch -d dev       # 删除dev分支
git checkout dev        # 切换到dev分支
git checkout -b dev     # 创建并切换分支
```

# dev 分支上线,合并到 master 分支

```bash
git checkout dev
git pull
git checkout master
git merge dev
git push -u origin master
```

# master 分支改动，需要更新 dev 分支

```bash
git checkout master
git pull
git checkout dev
git merge master
git push -u origin dev
```

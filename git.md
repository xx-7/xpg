# 常用操作

```bash

git config --global user.name "zz"
git config --global user.email zz@zz.com

git add -A
git commit -m "test"

git commit -a -m 'test'

git push -u origin master

#查看状态
git status

#新建分支
git checkout -b feature_b

#切换分支
git checkout master

#合并分支
git merge feature_b

#删除分支
git branch -d feature_b

#删除
git rm * -r

#拉取更新
git pull

#查看文件不同，可加文件路径
git diff

#自动合并失败,手动合并
git mergetool

#放弃本地修改强拉远程
git fetch origin
git reset --hard origin/master

#回到某次提交
git log 
git reset --hard $COMMIT

#推送已经创建
git remote add origin https://test.com/test/test.git

#切换验证方式
git remote -v
git remote rm origin
git remote add origin git@github.com:USER/PROJECT.git
```

```bash
git branch          #查看分支
git branch dev      #创建dev分支
git branch -d dev   #删除dev分支
git checkout dev    #切换到dev分支
git checkout -b dev #创建并切换分支
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

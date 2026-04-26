# Playwright

```bash

# env: node.js chrome

# install
sudo npm i -g @playwright/cli@latest

# 默认后台运行无界面
# --headed 有界面
playwright-cli open name.com --headed

# install skills
playwright-cli install --skills

# switch to codex
mv .claude .codex

# test
# codex 

# demo1

# Query: playwrightcli 参数 --headed --persistent, 打开百度, 问问今天天气怎么样？
# Gen Skill: 创建一个 query_weather Skill, 把刚才问天气全过程提炼出来保存到skill里面. 后面我只要让你查询天气, 你就能调用这个skill完成任务
# Gen Script: 你把刚才所有的playwright CLI 命令汇总成一个脚本, 执行脚本就能问天气
```
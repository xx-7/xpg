# env & install

```bash
# https://claude.com/product/claude-code

curl -fsSL https://claude.ai/install.sh | bash

~/.local/bin/claude

# 跳过启动验证
nano ~/.claude.json

"hasCompletedOnboarding": true,

# env
sudo pacman -S git nodejs-lts-krypton

# 三种模式
# shift + tab 切换模式
* ？ for shortcuts 修改文件前一定询问用户
* accept edits on 自动修改文件
* plan mode on 只讨论, 不修改文件

# 常用命令

* /clear            清空上下文
* /compact          压缩对话
* /cost             花费
* /logout /login    登录登出
* /model            切换模型
* /status           状态
* /doctor           检测

```

# 设置key

```bash

export ANTHROPIC_AUTH_TOKEN="API KEY"
export ANTHROPIC_BASE_URL="API URL"


~/.claude/settings.json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "API KEY",
    "ANTHROPIC_BASE_URL": "API URL",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1
  },
  "permissions": {
    "allow": [],
    "deny": []
  }
}

```

# 三方模型

## 阿里云百炼

```bash

# https://bailian.console.aliyun.com
# 登录 -> 模型 -> 模型用量 -> glm-5 -> 免费额度用完即停

# 创建apikey key
# 左下 -> API Key -> 创建

export ANTHROPIC_AUTH_TOKEN="API KEY"
export ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/apps/anthropic"
export ANTHROPIC_MODEL="glm-5"

```
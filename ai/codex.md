# Install

```bash

npm list -g --depth=0
sudo npm install -g @openai/codex
claude --version

```

# newcli

```bash


~/.codex/config.toml

model_provider = "fox"
model = "gpt-5.4"
model_reasoning_effort = "high"
disable_response_storage = true


[model_providers.fox]
name = "fox"
base_url = "https://code.newcli.com/codex/v1"
wire_api = "responses"
requires_openai_auth = true


~/.codex/auth.json

{
  "OPENAI_API_KEY": "API Key"
}


```
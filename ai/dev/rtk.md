# RTK

```bash

# install
cargo install --git https://github.com/rtk-ai/rtk

rtk --version   # Should show "rtk 0.28.2"
rtk gain        # Should show token savings stats

rtk init -g                     # Claude Code / Copilot (default)
rtk init -g --gemini            # Gemini CLI
rtk init -g --codex             # Codex (OpenAI)
rtk init -g --agent cursor      # Cursor
rtk init --agent windsurf       # Windsurf
rtk init --agent cline          # Cline / Roo Code
rtk init --agent kilocode       # Kilo Code
rtk init --agent antigravity    # Google Antigravity


```
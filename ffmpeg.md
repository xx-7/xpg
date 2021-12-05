# ffmpeg

```bash

# 音视频合并
ffmpeg -i audio.mp4 -i video.mp4 output.mp4

# 剪裁不缩放，输出中间1920x1080
ffmpeg -i src.mp4 -vf crop=1920:1080 output.mp4

```
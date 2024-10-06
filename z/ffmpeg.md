# ffmpeg

```bash

# 音视频合并
ffmpeg -i INPUT.mp4 -i video.mp4 OUTPUT.mp4

# 剪裁不缩放，输出中间1920x1080
ffmpeg -i INPUT.mp4 -vf crop=1920:1080 OUTPUT.mp4

# 垂直旋转
ffmpeg -i INPUT.mp4 -vf vflip -y OUTPUT.mp4

# 水平左右旋转
ffmpeg -i INPUT.mp4 -vf hflip -y OUTPUT.mp4

# 顺时针90度旋转
ffmpeg -i INPUT.mp4 -vf transpose=1 OUTPUT.mp4

# 逆时针90度旋转
ffmpeg -i INPUT.mp4 -vf transpose=2 OUTPUT.mp4


ffmpeg -i "https://bb.com/a.m3u8" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 mp4.mp4

```
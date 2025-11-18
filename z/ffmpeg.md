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


# 视频转成图片 r 帧数
# -f 格式
# image2: 将输出设置为一系列图像文件。
# mp4: 输出为MP4格式的视频文件。
# avi: 输出为AVI格式的视频文件。
# mov: 输出为MOV格式的视频文件。
# flv: 输出为FLV格式的视频文件。
# matroska: 输出为Matroska格式（MKV）的视频文件。
# mpeg: 输出为MPEG格式的视频文件。
# gif: 输出为GIF动画文件。
# wav: 输出为WAV音频文件。
# mp3: 输出为MP3音频文件。
# aac: 输出为AAC音频文件。
ffmpeg -i INPUT.mp4 -r 10 -f image2 pic/v_%3d.jpg

```

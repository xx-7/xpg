#

```bash

sudo pacman -Rs alsa-utils pulseaudio pulseaudio-alsa xfce4-pulseaudio-plugin pulsemixer pavucontrol pulseaudio-bluetooth


# 可解决录屏声音小
sudo pacman -S pipewire pipewire-audio pipewire-pulse xfce4-pulseaudio-plugin
paru -S sonusmix

# 新建虚拟输出设备
pactl load-module module-null-sink media.class=Audio/Sink sink_name=my-virtual-sink channel_map=stereo

# 删除
pactl unload-module module-null-sink

# 新建输入设备
pactl load-module module-null-sink  media.class=Audio/Sink sink_name=VirtualSpeaker sink_properties=device.description="Virtual Speaker"

pactl load-module module-null-sink media.class=Audio/Source sink_name=VirtualMic channel_map=front-left,front-right device.description="Virtual Microphone"




```
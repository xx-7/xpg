# usb 协议

- usb1.0                    1996.01    1.5Mbps
- usb1.1                    1998.09    12Mbps
- usb2.0                    2000.04    480Mbps
- usb3.0                    2008.11    5Gbps
- usb3.1 Gen1 (usb3.0)      2013.07    5Gbps
- usb3.1 Gen2               2013.07    10Gbps
- usb3.2 Gen1 (3.1 Gen1)    2017.09    5Gbps
- usb3.2 Gen2 (3.1 Gen2)    2017.09    10Gbps
- usb3.2 Gen1x2             2017.09    10Gbps
- usb3.2 Gen2x2             2017.09    20Gbps
- usb4 Gen1x2               2019.08    20Gbps
- usb4 Gen2x2               2019.08    40Gbps

# pin

- type-a  4pin 1.x-2.0
- type-a  9pin 1.x-3.2 Gen2
- type-c 24pin all

# type-a接口颜色

- 白色 1.x
- 黑色 2.0
- 蓝色 3.0
- 青色 3.1Gen1
- 红色 3.1Gen2/3.2
- 黄色 2.0/3.0 高功率
- 橘色 3.0 只充电

# type-c

## 母头

- A1   A2   A3   A4   A5   A6   A7   A8   A9   A10  A11  A12
- GND  TX1+ TX1- VBUS CC1  D+   D-   SBU1 VBUS RX2- RX2+ GND
- GND  RX1+ RX1- VBUS SBU2 D-   D+   CC2  VBUS TX2- TX2+ GND
- B12  B11  B10  B9   B8   B7   B6   B5   B4   B3   B2   B1
![](/assets/usb/1.png)

## 公头

- A12  A11  A10  A9   A8    A7   A6   A5   A4   A3   A2   A1
- GND  RX2+ RX2- VBUS SBU1  D-   D+   CC1  VBUS TX1- TX1+ GND
- GND  TX2+ TX2- VBUS VCONN           SBU2 VBUS RX1- RX1+ GND
- B1   B2   B3   B4   B5    B6   B7   B8   B9   B10  B11  B12
![](/assets/usb/2.png)

## 6pin

- 只充电
- 保留: B12,B9,A5,B5,A9,A12

## 12pin/16pin

- usb2.0
- 16pin实际也只有12pin,有4根两根合在一起了
- 保留: A1B12,A4B9,B8,A5,B7,A6,A7,B6,A8,B5,A9B4,A12B1
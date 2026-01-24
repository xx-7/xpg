```bash

# 全志平台camera 移植教程: https://www.cnblogs.com/weidongshan/articles/17183702.html

docker build -t v3szero -f ./v3s-zero/Dockerfile .

docker run -v $PWD/:/project -ti v3szero /bin/bash

arm-linux-gnueabihf-gcc -v


# 修改输入串口
#

u-boot/include/configs/sunxi-common.h
 #define CONFIG_CONS_INDEX              1      /* UART0 */

arch/arm/dts/sun8i-v3s-licheepi-zero.dts
chosen {
		stdout-path = "serial0:115200n8";
	};

# 添加到下面
&uart0 {
	pinctrl-0 = <&uart0_pins_a>;
	pinctrl-names = "default";
	status = "okay";
};

&spi0 {
	status = "okay";
	flash@0 {
		compatible = "windbond,xt25f128b", "jedec,spi-nor";
		reg = <0x0>;
		spi-max-frequency = <50000000>;
		#address-cells = <1>;
		#size-cells = <1>;
	};
};


```

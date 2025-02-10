
# u-boot 改为 uart2 输出

```bash


nano arch/arm/dts/sun8i-v3s-licheepi-zero.dts

# aliases 节点中添加
serial2 = &uart2;

# chosen 节点 修改 stdout-path = "serial0:115200n8";
stdout-path = "serial2:115200n8";

# 后面添加
&uart2 {
        pinctrl-0 = <&uart2_pins_a>;
        pinctrl-names = "default";
        status = "okay";
};

# soc -> pio:pinctrl -> uart0_pins_a: uart0@0 后面加入
nano arch/arm/dts/sun8i-v3s.dtsi
                        uart2_pins_a: uart2@0 {
                                pins = "PB0", "PB1";
                                function = "uart2";
                                bias-pull-up;
                        };

# CONFIG_BOOTARGS console 中 改为 ttyS2
nano include/configs/sun8i.h

# CONFIG_CONS_INDEX 改为 3
nano include/configs/sunxi-common.h

```


# linux 添加串口

```bash

# soc -> pin:pinctrl 节点下加入
nano ./arch/arm/boot/dts/sun8i-v3s.dtsi

                        uart1_pins_a: uart1@0 {
                                pins = "PE21", "PE22";
                                function = "uart1";
                                bias-pull-up;
                        };


                        uart2_pins_a: uart2@0 {
                                pins = "PB0", "PB1";
                                function = "uart2";
                                bias-pull-up;
                        };


nano ./arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts

&uart1 {
        pinctrl-0 = <&uart1_pins_a>;
        pinctrl-names = "default";
        status = "okay";
};

&uart2 {
        pinctrl-0 = <&uart2_pins_a>;
        pinctrl-names = "default";
        status = "okay";
};

```
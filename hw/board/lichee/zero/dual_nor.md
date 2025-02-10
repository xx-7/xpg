

# 多nor flash 

```bash

&spi0 {
        clock-frequency = <100000000>;
        pinctrl-0 = <&spi0_pins_a &spi0_pins_b>;
        pinctrl-1 = <&spi0_pins_c>;
        pinctrl-names = "default", "sleep";
        cs-gpios = <&pio PC 3 GPIO_ACTIVE_HIGH>, <&pio PC 0 GPIO_ACTIVE_HIGH>;
        spi_slave_mode = <0>;
        status = "okay";

        spi-nor@0 {
                compatible = "jedec,spi-nor";
                spi-max-frequency=<30000000>;
                reg = <0x0>;//片选0
                spi-rx-bus-width=<0x01>;
                spi-tx-bus-width=<0x01>;
                status="okay";
        };

        spi-nor@1 {
                compatible = "jedec,spi-nor";
                spi-max-frequency=<30000000>;
                reg = <0x1>;//片选1
                spi-rx-bus-width=<0x01>;
                spi-tx-bus-width=<0x01>;
                status="okay";
        };

};
```
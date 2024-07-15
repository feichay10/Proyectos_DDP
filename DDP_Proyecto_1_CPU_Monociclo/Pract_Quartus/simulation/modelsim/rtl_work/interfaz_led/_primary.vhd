library verilog;
use verilog.vl_types.all;
entity interfaz_led is
    port(
        bus_dato        : inout  vl_logic_vector(15 downto 0);
        dispositivo_write_enable: in     vl_logic_vector(2 downto 0);
        led_output      : out    vl_logic_vector(1 downto 0)
    );
end interfaz_led;

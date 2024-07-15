library verilog;
use verilog.vl_types.all;
entity mapeo_dis is
    port(
        direccion       : inout  vl_logic_vector(15 downto 0);
        write_enable    : in     vl_logic;
        dispositivo_write_enable: out    vl_logic_vector(2 downto 0)
    );
end mapeo_dis;

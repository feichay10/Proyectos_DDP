library verilog;
use verilog.vl_types.all;
entity cpu is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        ir1             : in     vl_logic;
        opcode_salida   : out    vl_logic_vector(7 downto 0);
        io_output       : out    vl_logic_vector(1 downto 0)
    );
end cpu;

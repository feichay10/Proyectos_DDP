library verilog;
use verilog.vl_types.all;
entity registro_interrupcion is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        ir              : in     vl_logic_vector(2 downto 0);
        next_ir         : out    vl_logic_vector(2 downto 0)
    );
end registro_interrupcion;

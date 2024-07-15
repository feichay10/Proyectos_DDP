library verilog;
use verilog.vl_types.all;
entity stack is
    port(
        clk             : in     vl_logic;
        push            : in     vl_logic;
        pop             : in     vl_logic;
        overflow        : out    vl_logic;
        underflow       : out    vl_logic;
        stack_in        : in     vl_logic_vector(9 downto 0);
        stack_out       : out    vl_logic_vector(9 downto 0)
    );
end stack;

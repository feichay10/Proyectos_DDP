library verilog;
use verilog.vl_types.all;
entity cd is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        s_inc           : in     vl_logic;
        s_inm           : in     vl_logic;
        we3             : in     vl_logic;
        wez             : in     vl_logic;
        wcalli          : in     vl_logic;
        push            : in     vl_logic;
        pop             : in     vl_logic;
        push_inm        : in     vl_logic;
        pop_inm         : in     vl_logic;
        op_alu          : in     vl_logic_vector(3 downto 0);
        dir_sal_in      : in     vl_logic_vector(9 downto 0);
        z               : out    vl_logic;
        overflow        : out    vl_logic;
        underflow       : out    vl_logic;
        addr            : inout  vl_logic_vector(15 downto 0);
        data            : inout  vl_logic_vector(15 downto 0);
        opcode          : out    vl_logic_vector(7 downto 0)
    );
end cd;

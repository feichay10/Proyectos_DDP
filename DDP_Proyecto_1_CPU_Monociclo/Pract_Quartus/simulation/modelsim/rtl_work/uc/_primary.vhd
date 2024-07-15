library verilog;
use verilog.vl_types.all;
entity uc is
    port(
        opcode          : in     vl_logic_vector(7 downto 0);
        z               : in     vl_logic;
        e_interrupt     : in     vl_logic;
        s_inc           : out    vl_logic;
        s_inm           : out    vl_logic;
        we3             : out    vl_logic;
        wez             : out    vl_logic;
        wcalli          : out    vl_logic;
        push            : out    vl_logic;
        pop             : out    vl_logic;
        push_inm        : out    vl_logic;
        pop_inm         : out    vl_logic;
        escritura       : out    vl_logic;
        ir_attended     : in     vl_logic_vector(2 downto 0);
        op_alu          : out    vl_logic_vector(3 downto 0);
        dir_sal_in      : out    vl_logic_vector(9 downto 0)
    );
end uc;

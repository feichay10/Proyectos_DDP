library verilog;
use verilog.vl_types.all;
entity ffi is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        push_inm        : in     vl_logic;
        pop_inm         : in     vl_logic;
        previous_ire    : in     vl_logic;
        next_ire        : out    vl_logic
    );
end ffi;

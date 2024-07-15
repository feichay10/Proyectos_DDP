library verilog;
use verilog.vl_types.all;
entity codificador is
    port(
        ir1             : in     vl_logic;
        ir_attended     : out    vl_logic_vector(2 downto 0)
    );
end codificador;

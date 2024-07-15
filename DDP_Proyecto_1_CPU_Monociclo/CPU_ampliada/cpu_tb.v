module cpu_tb;


reg clk, reset, ir1;
wire [7:0] opcode;



// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;
end

// instanciación del procesador
cpu micpu(clk, reset, ir1, opcode);

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset 
  
end

initial
begin
  ir1 = 1'b0;
  #20
  ir1 = 1'b1;
  #(30*90);  
  $finish;
end

endmodule
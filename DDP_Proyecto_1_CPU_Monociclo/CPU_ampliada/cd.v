module cd(input wire clk, reset, s_inc, s_inm, we3,
 wez, wcalli, push, pop, push_inm, pop_inm,
  input wire [3:0] op_alu, input wire [9:0] dir_sal_in,
   output wire z, overflow, underflow, inout wire [15:0] addr,
    data, output wire [7:0] opcode);
    
  // Camino de datos de instrucciones de un solo ciclo
  wire zero, zero_select, zero_guard, sel_entrada_pc;
  wire [9:0] dir_salto, sig_inst, inst_a_ejec, salida_pc, inst_pc, salida_pila, incremento, salto;
  wire [15:0] reg_1, reg_2, dato_escr, oper_alu, dato_escrito;
  wire [31:0] instruccion;
  /*
  // Instancias
  assign sel_entrada_pc = pop | pop_inm;
  mux2 #(10) seleccionar_incremento(10'b0000000001, 10'b0, wcalli, incremento);
  sum inc_instruc(salida_pc, incremento, sig_inst);
  mux2 #(10) seleccionar_salto(dir_salto, dir_sal_in, wcalli, salto);
  mux2 #(10) sel_instruc(salto, sig_inst, s_inc, inst_a_ejec);
  stack pila(clk, push, pop, overflow, underflow, sig_inst, salida_pila);
  mux2 #(10) entrada_pc(inst_a_ejec, salida_pila, sel_entrada_pc, inst_pc);
  registro #(10) pc(clk, reset, inst_pc, salida_pc);
  memprog mem_prog(clk, salida_pc, instruc);
  regfile ban_reg(clk, we3, instruc[7:4], instruc[23:20], instruc[3:0], dato_escr, reg_1, reg_2);
  alu alu1(oper_alu, reg_2, op_alu, dato_escr, zero);
  ffd ffz(clk, reset, zero_select, wez, z);
  ffd ffzi(clk, reset, z, push_inm, zero_guard);
  mux2 #(1) selector_zero(zero, zero_guard, pop_inm, zero_select);
  mux2 #(16) entrada_alu (reg_1, instruc[19:4], s_inm, oper_alu);
  */
  
  assign sel_entrada_pc = pop | pop_inm;
  
  //Multiplexores
  mux2 #(10) seleccionar_incremento(10'b0000000001, 10'b0, wcalli, incremento);
  mux2 #(10) seleccionar_salto(dir_salto, dir_sal_in, wcalli, salto);
  mux2 #(10) seleccionar_instruc(salto, sig_inst, s_inc, inst_a_ejec);
  mux2 #(10) entrada_pc(inst_a_ejec, salida_pila, sel_entrada_pc, inst_pc);
  mux2 #(1) selector_zero(zero, zero_guard, pop_inm, zero_select);
  mux2 #(16) entrada_alu (reg_1, instruccion[19:4], s_inm, oper_alu);
  
  //Suma
  sum incremento_instruc(salida_pc, incremento, sig_inst);
  
  //Pila
  stack pila(clk, push, pop, overflow, underflow, sig_inst, salida_pila);
  
  //PC
  registro #(10) pc(clk, reset, inst_pc, salida_pc);
  
  //Memprog&Regfile
  memprog mem_prog(clk, salida_pc, instruccion);
  regfile ban_reg(clk, we3, instruccion[7:4], instruccion[23:20], instruccion[3:0], dato_escr, reg_1, reg_2);
  
  //Alu
  alu alu1(oper_alu, reg_2, op_alu, dato_escr, zero);
  
  //Biestables
  ffd ffz(clk, reset, zero_select, wez, z);
  ffd ffzi(clk, reset, z, push_inm, zero_guard);
  
  
  // Asignaciones
  assign addr = reg_1;
  assign data = reg_2;
  assign dir_salto = instruccion[23:14];
  assign opcode = instruccion[31:24];
endmodule

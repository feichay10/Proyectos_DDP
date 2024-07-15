module cpu(input wire clk, reset, ir1, output wire [7:0] opcode_salida, output wire[1:0] io_output);
//Procesador sin memoria de datos de un solo ciclo
  wire s_inc, s_inm, we3, wez, wcalli, push, pop, push_inm, pop_inm, escritura, z, overflow, underflow;
  wire previous_ire, next_ire;
  wire [7:0] opcode;
  wire [9:0] dir_sal_in;
  wire [2:0] ir_attended, prev_ir, next_ir;
  wire [3:0] op_alu;
  wire [15:0] addr, data;
  wire [2:0] dispositivo_write_enable;
  wire [5:0] led_output;
  
  //Manejo de las interrupciones
  registro_interrupcion registro_interrupcion_1(clk, pop_inm, ir_attended, next_ir);
  codificador codificador_senal(ir1, ir_attended);
  ffi ffi_0(clk, reset, push_inm, pop_inm, previous_ire, next_ire);
  ffd ffd_0(clk, reset, next_ire, 1'b1, previous_ire);
  
  //Interfaz led
  mapeo_dis mapeo_dispositivos(addr, escritura, dispositivo_write_enable);
  interfaz_led interfaz_led_1(data, dispositivo_write_enable, led_output);
  
  
  //Unidad de control y Camino de datos
  uc UnidadDeControl(opcode, z, previous_ire, s_inc, s_inm, we3, wez, wcalli, push, pop, push_inm, pop_inm, escritura, next_ir, op_alu, dir_sal_in);
  cd CaminoDeDatos(clk, reset, s_inc, s_inm, we3, wez, wcalli, push, pop, push_inm, pop_inm, op_alu, dir_sal_in, z, overflow, underflow, addr, data, opcode);
  
  assign io_output = led_output;
  assign opcode_salida = opcode;
  
endmodule

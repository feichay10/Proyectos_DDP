module uc(input wire [7:0] opcode, input wire z,
 e_interrupt, output reg s_inc, s_inm, we3, wez, wcalli,
  push, pop, push_inm, pop_inm, escritura,
   input wire [2:0] ir_attended,
    output reg [3:0] op_alu, output reg [9:0] dir_sal_in);
  
  always @(*)
    if(ir_attended != 3'b000 && e_interrupt == 1'b1)
      begin
		s_inc = 1'b0;
		s_inm = 1'b0;
		we3 = 1'b0;
		wez = 1'b0; 
		pop = 1'b0;
		pop_inm = 1'b0;
		escritura = 1'b0;
		op_alu = opcode[5:2];
      case(ir_attended)
        3'b001:
        begin
          dir_sal_in = 10'b1101100000;
          push = 1'b1;
          push_inm = 1'b1;
          s_inc = 1'b0;
          wcalli = push_inm & e_interrupt;  // Se produce la activacion si se produce un push de interrupción y las interrupciones están activadas
			
        end
        default:
        begin
          dir_sal_in = 10'b0000000000;
          push = 1'b0;
          push_inm = 1'b0;
          wcalli = push_inm & e_interrupt;
        end
      endcase
      end
    else
      begin
		dir_sal_in = 10'b0000000000;
      casex (opcode)
		
			// Instrucciones aritméticas con registros. 
        8'b10xxxxxx:  
        begin
          s_inc = 1'b1;
          s_inm = 1'b0;
          we3 = 1'b1;
          wez = 1'b1;
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
		  
			// Instrucciones aritméticas con constantes. 
        8'b11xxxxxx:  
        begin
          s_inc = 1'b1;
          s_inm = 1'b1;
          we3 = 1'b1;
          wez = 1'b1;
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
  
			// Instrucciones de carga inmediata.
        8'b00xxxxxx:  
        begin
          s_inc = 1'b1;
          s_inm = 1'b1;
          we3 = 1'b1;
          wez = 1'b0;
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
		  
			// Salto incondicional.
        8'b01000100:  
        begin
          s_inc = 1'b0;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b0;
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
  
			// Salto condicional si fue 0. 
		  8'b01001000:  
        begin
          s_inc = z?1'b0:1'b1;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b0;
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
		  
        // Salto condicional si no fue 0.
        8'b01001100:
        begin
          s_inc = z?1'b1:1'b0;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b0;
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
		  
			// Salto a subrutina
        8'b01110000:
        begin
          s_inc = 1'b0;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b0;
          push = 1'b1;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
		  
        // Salto a dirección de retorno de subrutina
        8'b01100000:
        begin
          s_inc = 1'b0;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b0;
          push = 1'b0;
          pop = 1'b1;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
  
			// Salto a dirección de retorno de subrutina de interrupción
        8'b01111000:
        begin
          s_inc = 1'b0;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b1;
          push = 1'b0;
          pop = 1'b1;
          push_inm = 1'b0;
          pop_inm = 1'b1;
          escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
		  
			// Escritura dispositivo E/S
        8'b01000000:
        begin
          s_inc = 1'b1;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b0; 
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
          escritura = 1'b1;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
        end
  
	default:
		  begin
		      s_inc = 1'b0;
          s_inm = 1'b0;
          we3 = 1'b0;
          wez = 1'b0;
          push = 1'b0;
          pop = 1'b0;
          push_inm = 1'b0;
          pop_inm = 1'b0;
			    escritura = 1'b0;
          wcalli = push_inm & e_interrupt;
          op_alu = opcode[5:2];
		  end
      endcase
      end

endmodule
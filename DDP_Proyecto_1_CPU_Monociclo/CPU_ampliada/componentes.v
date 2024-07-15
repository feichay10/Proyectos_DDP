//Banco de registros de dos salidas y una entrada
module regfile(input  wire        clk, 
               input  wire        we3,           //Habilitar de escritura
               input  wire [3:0]  ra1, ra2, wa3, //Direcciones de regs leidos y reg a escribir
               input  wire [15:0]  wd3, 			 //Dato para escribir
               output wire [15:0]  rd1, rd2);     //Datos que han sido leidos

  reg [15:0] regb[0:15]; //memoria de 16 registros de 16 bits de ancho

  initial
  begin
    $readmemb("//home//alumno//Escritorio//CPU_base//regfile.dat",regb);
  end  
  
  always @(posedge clk)
    if (we3) regb[wa3] <= wd3;	
  
  assign rd1 = (ra1 != 0) ? regb[ra1] : 16'b0;
  assign rd2 = (ra2 != 0) ? regb[ra2] : 16'b0;

endmodule

// Habilitador de interrupciones
module ffi(input wire clk, reset, push_inm, pop_inm, previous_ire, output reg next_ire);
  always @(posedge reset, posedge clk)
  if(reset)
    begin
    next_ire = 1'b1;
    end
  else
    if(previous_ire == 1'b1 && push_inm)
      begin
      next_ire = 1'b0;
      end
    else if(previous_ire == 1'b0 && pop_inm)
    begin
      next_ire = 1'b1;
    end

    else
    begin
      next_ire = previous_ire;
    end
endmodule

// Habilitador de interrupciones
module registro_interrupcion(input wire clk, reset, input wire [2:0] ir, output reg [2:0] next_ir);
  reg [2:0] int_state, prev_state;
  always @* begin
  prev_state <= int_state;
    if (reset) 
      int_state <= 3'b000;
	 else if (ir != 3'b000) 
      int_state <= ir; 
	 else
      int_state <= prev_state;	
	 
  end
  always @(posedge clk)
  begin
    next_ir <= int_state;
  end
endmodule

// Manejador de interrupciones
module codificador(input wire ir1, output reg[2:0] ir_attended);
  always @(*)
  if (ir1 == 0) 
  begin
     ir_attended = 3'b001;
  end
  else
  begin
     ir_attended = 3'b000;
  end
endmodule

// Pila
module stack(input wire clk, push, pop, output reg overflow, underflow, input wire [9:0] stack_in, output reg [9:0] stack_out);
  reg [9:0] stack[0:15];
  integer stack_pointer = 0;
  initial
  begin
    $readmemb("//home//alumno//Escritorio//CPU_base//stackfile.dat",stack); // inicializa la pila
  end
  always @(posedge clk)
    if(push)
      begin
        stack[stack_pointer] = stack_in;
        stack_pointer = stack_pointer + 1;
        stack_out = stack[stack_pointer - 1];
        if(stack_pointer > 15)
          overflow = 1;
        else
          overflow = 0;
      end
    else if(pop)
      begin
		    stack[stack_pointer - 1] = 10'bxxxxxxxxxx;
        stack_pointer = stack_pointer - 1;
        stack_out = stack[stack_pointer - 1];
        if(stack_pointer < 0)
          underflow = 1;
        else
          underflow = 0;
      end   
endmodule

//modulo sumador  
module sum(input  wire [9:0] a, b,
             output wire [9:0] y);

  assign y = a + b;

endmodule

//modulo registro para modelar el PC, cambia en cada flanco de subida de reloj o de reset
module registro #(parameter WIDTH = 8)
              (input wire             clk, reset,
               input wire [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

  always @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;

endmodule


//modulo multiplexor, si s=1 sale d1, s=0 sale d0
module mux2 #(parameter WIDTH = 8)
             (input  wire [WIDTH-1:0] d0, d1, 
              input  wire             s, 
              output wire [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 

endmodule

//Biestable para el flag de cero
//Biestable tipo D sincrono con reset asincrono por flanco y entrada de habilitaciï¿½n de carga
module ffd(input wire clk, reset, d, carga, output reg q);

  always @(posedge clk, posedge reset)
    if (reset)
	    q <= 1'b0;
	  else
	    if (carga)
	      q <= d;

endmodule 


// Memoria para mapear dispositivos E/S
module mapeo_dis(inout wire [15:0] direccion, input wire write_enable, output wire [2:0] dispositivo_write_enable);
  reg [15:0] memoria [255:0];  // Memoria de 256 direcciones de 8 bits
  
  reg [2:0] dispositivo_write_enable_internal;

  always @(*)
  begin
    if(write_enable == 1'b1)
	 begin
	 
    case (direccion)
      //Direccion del dispositivo led
      16'b0000000000000000: dispositivo_write_enable_internal = 3'b001; // Led 0
      default: dispositivo_write_enable_internal = 3'b000; // No hay dispositivo seleccionado
		
    endcase
	 end
	 else 
	 begin
	 dispositivo_write_enable_internal = 3'b000;
	 end
	end
  
  assign dispositivo_write_enable = dispositivo_write_enable_internal;
endmodule

// Interfaz Leds
module interfaz_led(inout wire [15:0] bus_dato, input wire [2:0] dispositivo_write_enable, output wire [1:0] led_output);
  reg [1:0] registro_leds = 2'b0;
  reg valor;

  always @(*) begin
    if (dispositivo_write_enable != 3'b000)
	 begin

      case (dispositivo_write_enable)
        3'b001: 
					  begin
					  valor = (bus_dato != 16'b0) ? 1'b1 : 1'b0;
					  registro_leds[0] <= valor; // Led 0
					  end
		  
        default: 
					  begin
					  valor <= valor;
					  registro_leds[0] <= registro_leds[0]; // Led 0
					  end 
		  
      endcase
					end
					else
					begin
					  valor <= valor;
					  registro_leds[0] <= registro_leds[0]; // Led 0
					end
  end
  
  assign led_output = registro_leds;
endmodule



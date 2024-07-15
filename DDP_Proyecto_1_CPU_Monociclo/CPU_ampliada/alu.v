module alu(input wire [15:0] a, b,
           input wire [3:0] op_alu,
           output wire [15:0] y,
           output wire zero);

reg [15:0] s;		   
		   
always @(a, b, op_alu)
begin
  case (op_alu)              
    4'b0000: s = a;
    4'b0001: s = ~a;
    4'b0010: s = a + b;
    4'b0011: s = a - b;
    4'b0100: s = a & b;
    4'b0101: s = a | b;
    4'b0110: s = -a;
    4'b0111: s = -b;
    4'b1000: s = b - a;
    4'b1001: s = b;
	default: s = 16'bx; //desconocido en cualquier otro caso (x � z), por si se modifica el c�digo
  endcase
end

assign y = s;

//Calculo del flag de cero
assign zero = ~(|y);   //operador de reducci�n |y hace la or de los bits del vector 'y' y devuelve 1 bit resultado
		   
endmodule
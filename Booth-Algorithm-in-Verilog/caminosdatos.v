/*
-Actividad Previa: Diseño de Procesadores
-Alumno: Cheuk Kelly Ng Pante
-Correo: alu0101364544@ull.edu.es
-Curso 2021 - 2022
-Compilacion: iverilog -o ActPrevia multiplicador_tb.v multiplicador.v uc.v componentes.v caminosdatos.v 
-Simulación: vvp ActPrevia
*/

module caminosdatos (input wire [2:0] Mcador, Mcando, input wire clk, start, cargaA, cargaQ, cargaM, suma, desplazaAQ, output wire [1:0] q, output wire [5:0] producto);
    // Cables
    wire [3:0] SalA_to_Sum, SalM_to_Sum, SalQ;
    wire [3:0] EntQ, EntM, EntA;
    wire aux;

    // Valores a 4 bits
    assign EntQ = {Mcador, 1'b0}; 
    assign EntM = {Mcando[2], Mcando};

    // Registros
    registro4 A(EntA, SalA_to_Sum[3], cargaA, desplazaAQ, clk, start, SalA_to_Sum);
    registro4 Q(EntQ, SalA_to_Sum[0], cargaQ, desplazaAQ, clk, 1'b0, SalQ);
    registro4 M(EntM, 1'b0, cargaM, 1'b0, clk, 1'b0, SalM_to_Sum);

    // Sumador
    sum_resta4 sumador(EntA, aux, SalA_to_Sum, SalM_to_Sum, suma);

    // Salidas
    assign producto = {SalA_to_Sum[2:0], SalQ[3:1]};
    assign q = {SalQ[1], SalQ[0]};

endmodule
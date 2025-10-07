`timescale 1ns/1ps

module four_bit_adder_tb;
    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    wire [3:0] sum;
    wire cout;
    
    // Промежуточные сигналы для мониторинга
    wire [4:0] result;
    assign result = {cout, sum};
    
    // Экземпляр тестируемого модуля
    four_bit_adder_nor uut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, four_bit_adder_tb);
        
        // Простое сложение
        a = 4'b0000; b = 4'b0000; cin = 0; #10;
        a = 4'b0001; b = 4'b0001; cin = 0; #10;
        a = 4'b0011; b = 4'b0010; cin = 0; #10;
        
        // С переносом между разрядами
        a = 4'b1111; b = 4'b0001; cin = 0; #10;
        a = 4'b1000; b = 4'b1000; cin = 0; #10;
        
        // С входным переносом
        a = 4'b0000; b = 4'b0000; cin = 1; #10;
        a = 4'b1111; b = 4'b0000; cin = 1; #10;
        
        // Максимальные значения
        a = 4'b1111; b = 4'b1111; cin = 0; #10;
        a = 4'b1111; b = 4'b1111; cin = 1; #10;
        
        // Случайные тесты
        a = 4'b1010; b = 4'b0101; cin = 0; #10;
        a = 4'b1100; b = 4'b0011; cin = 1; #10;
        
        $finish;
    end
    
    initial begin
        $monitor("Time: %0t A=%b B=%b Cin=%b → Sum=%b Cout=%b Result=%b",
                 $time, a, b, cin, sum, cout, result);
    end
endmodule
`timescale 1ns/1ps
module bit8_csa_tb;
wire [7:0]S;
wire Cout;
reg [7:0] A,B;
reg Cin;
bit8_csa dut (S,Cout,A,B,Cin);
initial
begin
A=8'd25;B=8'D30;Cin=0;
#10;
A=8'd100;B=8'd50;Cin=1;
#10;
A=8'd255;B=8'd1;Cin=0;
#10;
A=8'd150;B=8'd100;Cin=1;
#10;
$finish;
end
initial
begin
$monitor ("Time=%0t A=%d B=%d Cin=%b SUM=%d Cout=%b",$time,A,B,Cin,S,Cout);
$dumpfile("8BITCARRYSELECTADDER.vcd");
$dumpvars(0,bit8_csa_tb);
end 
endmodule

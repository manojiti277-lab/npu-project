module tb_optimized_multiplier;
 reg clk, reset;
 reg [3:0] multiplicand, multiplier;
 wire [7:0] product;
 wire done;

 optimized_multiplier dut(
  clk, reset, multiplicand, multiplier, product, done
  );
always #5 clk = ~clk;

 initial begin
 clk = 0;
   reset = 1;
  multiplicand = 4'b1011;
  multiplier = 4'b0111;
 #12 reset = 0;
  #40;
  reset = 1;
  multiplicand = 4'b0110;
   multiplier = 4'b1001;
	#10 reset = 0;
   #40;
    $finish;
    end
endmodule
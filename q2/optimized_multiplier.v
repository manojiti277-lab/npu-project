module optimized_multiplier(
    input clk, reset,
    input [3:0] multiplicand, multiplier,
    output [7:0] product,
    output reg done
);
 reg [3:0] M, A, Q;
 reg C;
 reg [2:0] count;
 wire [4:0] sum;
 assign sum = {1'b0, A} + (Q[0] ? {1'b0, M} : 5'b0);
 assign product = {A, Q};
 always @(posedge clk) begin
    if (reset) begin
   M <= multiplicand;
    Q <= multiplier;
    A <= 0;
    C <= 0;
     count <= 0;
     done <= 0;
  end
else if (count < 4) begin
    {C, A, Q} <= {sum, Q} >> 1;
     count <= count + 1'b1;
    if (count == 3)//ths says whenever count is 3, one full multiplication completed
      done <= 1;
   end
    end
endmodule
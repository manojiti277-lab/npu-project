module tb_round_robin_arbiter;

reg clk, rst;
reg [3:0] req;
wire [3:0] gnt;

round_robin_arbiter dut(
    .clk(clk), .rst(rst),
    .req(req), .gnt(gnt)
);
always #5 clk = ~clk;
initial begin
  clk = 0;
  rst = 1;
   req = 4'b0000;
  $monitor($time, " rst=%b req=%b gnt=%b", rst, req, gnt);
 #10 rst = 0;
 #10 req = 4'b1111;  // all requesters
 #80 req = 4'b1010;  // requesters 1 and 3
 #40 req = 4'b0100;  // requester 2
 #20 req = 4'b0000;  // no requests
  #20 $finish;
end
endmodule
module round_robin_arbiter(
    input clk, rst,
    input [3:0] req,
    output reg [3:0] gnt
);
reg [1:0] ptr;
reg [3:0] next_gnt;
always @(*) begin
    next_gnt = 4'b0000; 
  case(ptr)
  0: begin   /*so here it is indicating that whenever we press ptr 0,it should give highest preference oth requeter
  if he do not want than it will be passed to next person.all case works same way*/
       if(req[0]) next_gnt = 4'b0001;  /*0>1>2>3*/
  else if(req[1]) next_gnt = 4'b0010;
 else if(req[2]) next_gnt = 4'b0100; 
 else if(req[3]) next_gnt = 4'b1000;
     end
  1: begin
     if(req[1]) next_gnt = 4'b0010;/* 1>2>3>0*/
 else if(req[2]) next_gnt = 4'b0100; 
else if(req[3]) next_gnt = 4'b1000;
 else if(req[0]) next_gnt = 4'b0001;
        end
  2: begin
     if(req[2]) next_gnt = 4'b0100; /*2>3>0>1*/
else if(req[3]) next_gnt = 4'b1000;
else if(req[0]) next_gnt = 4'b0001;
 else if(req[1]) next_gnt = 4'b0010;
        end
  3: begin
      if(req[3]) next_gnt = 4'b1000;
 else if(req[0]) next_gnt = 4'b0001;
 else if(req[1]) next_gnt = 4'b0010;
 else if(req[2]) next_gnt = 4'b0100;
        end
    endcase
end
always @(posedge clk or posedge rst) begin
     if(rst) begin
    gnt <= 0;
     ptr <= 0;
    end
 else begin
    gnt <= next_gnt;
   case(next_gnt)    
  4'b0001: ptr <= 1;/*in this we are saying that that after 0th requester completes, change pointer to 1 .so when poniter change to 1 ,requster 1 gets more priority   */
   4'b0010: ptr <= 2;
   4'b0100: ptr <= 3;
   4'b1000: ptr <= 0;
 default: ptr <= ptr; /*when no one is requesting*/
 endcase
 end
end
endmodule
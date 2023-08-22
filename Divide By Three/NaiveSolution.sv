module div_by_three (
  input   logic    clk,
  input   logic    reset,

  input   logic    x_i,

  output  logic    div_o

);
  //the problem with this implementation is it uses a lot of resources and
  //is limited by the size of the registers as to how long it can go on for.
  reg [127:0] num;
  reg [127:0] num_q;
  assign num = {num_q[126:0], x_i};
  assign div_o = (num % 3) == 128'b0;
  always_ff @(posedge clk or posedge reset) begin
   if(reset)
     num_q <= 128'b0;
   else
   	num_q[127:0] <= num[127:0];
  end

endmodule

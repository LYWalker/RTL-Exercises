module atomic_counters (
  input                   clk,
  input                   reset,
  input                   trig_i,
  input                   req_i,
  input                   atomic_i,
  output logic            ack_o,
  output logic[31:0]      count_o
);

  // --------------------------------------------------------
  // DO NOT CHANGE ANYTHING HERE
  // --------------------------------------------------------
  // current count
  logic [63:0] count_q;
  // next count
  logic [63:0] count;

  always_ff @(posedge clk or posedge reset)
    if (reset)
      count_q[63:0] <= 64'h0;
    else
      count_q[63:0] <= count;
  // --------------------------------------------------------
  
  reg req_q, atomic_q;

  always_ff @(posedge clk or posedge reset)
    if (reset) begin
      atomic_q <= 1'b0;
      req_q    <= 1'b0;
    end
    else begin
      atomic_q <= atomic_i;
      req_q    <= req_i;
    end
  
  assign count_o = req_q ? (atomic_q ? count_q[31:0] : UpperBits[31:0]) : 32'b0;
  assign ack_o = req_q;
  assign count[63:0] = count_q[63:0] + {63'b0, trig_i};
  
  //store the upperbits when lowerbits are sent, to ensure atomicity
  reg [31:0] UpperBits;
  
  always_ff @(posedge clk or posedge reset) begin
    if(reset)
      UpperBits[31:0] <= 32'b0;
    else if(atomic_i) begin
        UpperBits[31:0] <= count[63:32];
    end
  end
endmodule
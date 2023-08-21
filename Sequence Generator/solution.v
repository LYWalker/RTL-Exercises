module seq_generator (
  input   wire        clk,
  input   wire        reset,

  output  wire [31:0] seq_o
);

  // n(x)=n(x-2)+n(x-3)
  // instead of keeping track of x-1,x-2,x-3, I keep track of x-1,x-2 and buffer the output one cycle
  reg [31:0] op_a = 32'b0;
  reg [31:0] op_b = 32'b0;
  localparam Running = 1'b1;
  localparam Reset = 1'b0;
  
  reg  State = Reset;
  reg [31:0] outputReg = 32'h0;
  
  assign seq_o = outputReg;
  
  always @(posedge clk or posedge reset) begin
    
    if(reset) begin
      State <= Reset;
    end else begin
      case(State)
        Running: begin
          outputReg <= op_a + op_b;
          op_a <= op_b;
          op_b <= outputReg;
        end
        Reset: begin
        	op_a <= 32'b0;
  				op_b <= 32'b1;
          outputReg <= 32'b0;
          State <= Running;
        end
        default:;
      endcase
    end
  end 
endmodule

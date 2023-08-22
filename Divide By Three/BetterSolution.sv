module div_by_three (
  input   logic    clk,
  input   logic    reset,

  input   logic    x_i,

  output  logic    div_o

);

  //let's do this with modular arithmetic
  //adding a 0 is the same as multiplying by 2
  //adding a 1 is multiplying by 2, add 1

  //if x ≡ 0 (mod 3), then 2x ≡ 0 (mod 3), 2x + 1 ≡ 1 (mod 3)
  //if x ≡ 1 (mod 3), then 2x ≡ 2 (mod 3), 2x + 1 ≡ 0 (mod 3)
  //if x ≡ 2 (mod 3), then 2x ≡ 1 (mod 3), 2x + 1 ≡ 2 (mod 3)
  
  //using this we can create a FSM with the remainder being the state

  reg [1:0] state_q; //current state
  reg [1:0] state;   //next state
  reg div;

  localparam REM_0 = 2'h0;
  localparam REM_1 = 2'h1;
  localparam REM_2 = 2'h2;
 
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      state_q <= REM_0;
    else
      state_q <= state;
  end
  
  always_comb begin
    div = 1'b0;
    case(state_q)
      REM_0:
        begin
          if(x_i)
            state = REM_1;
          else begin
            state = REM_0;
            div = 1'b1;
          end
        end
      REM_1:
        begin
          if(x_i) begin
            state = REM_0;
            div = 1'b1;
          end else begin
            state = REM_2;
          end
        end
      REM_2:
        begin
          if(x_i)
            state = REM_2;
          else begin
            state = REM_1;
          end
        end
      default:
        begin
        	state = REM_0;
      		div = 1'b1;
        end     
    endcase
  end
  assign div_o = div;
endmodule

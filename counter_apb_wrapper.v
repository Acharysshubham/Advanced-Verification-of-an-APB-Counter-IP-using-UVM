module counter_apb_wrapper (
  input  logic        PCLK,
  input  logic        PRESETn,
  input  logic [31:0] PADDR,
  input  logic        PSEL,
  input  logic        PENABLE,
  input  logic        PWRITE,
  input  logic [31:0] PWDATA,
  output logic [31:0] PRDATA,
  output logic        PREADY
);
  logic counter_rst_n;
  wire  [3:0] counter_q;

  top_module dut (
    .clk_100MHz(PCLK),
    .rst_n(PRESETn && counter_rst_n),
    .q(counter_q)
  );

  always_ff @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
      counter_rst_n <= 1'b1;
    end else begin
      if (PSEL && PENABLE && PWRITE) begin
        case (PADDR)
          'h04: counter_rst_n <= (PWDATA[0] == 0); // Reset when bit 0 is 1
          default: ;
        endcase
      end else begin
        counter_rst_n <= 1'b1;
      end
    end
  end

  always_comb begin
    case (PADDR)
      'h00:   PRDATA = 32'h000DECAF;
      'h08:   PRDATA = {28'b0, counter_q};
      default: PRDATA = 32'h0;
    endcase
  end

  assign PREADY = 1'b1;
endmodule

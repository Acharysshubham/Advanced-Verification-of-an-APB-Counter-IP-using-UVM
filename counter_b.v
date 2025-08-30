module counter_b(
    input clk, reset_n,
    output reg [3:0] q
);
    wire j0, j1, k1, j2, k2;
    wire reset_bcd = (q == 4'b0101);
    assign j0 = 1'b1;
    assign j1 = q[0];
    assign k1 = q[0];
    assign j2 = q[1] & q[0];
    assign k2 = q[1] & q[0];

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n || reset_bcd) begin
            q <= 4'b0000;
        end else begin
            q[0] <= j0 ^ q[0];
            q[1] <= (j1 & ~q[1]) | (~k1 & q[1]);
            q[2] <= (j2 & ~q[2]) | (~k2 & q[2]);
            q[3] <= 1'b0;
        end
    end

    // --- SystemVerilog Assertions (SVA) Block ---
    p_never_above_5: assert property (@(posedge clk) !(q > 5))
      else $error("Assertion Failed: Counter value %0d exceeded 5!", q);

    p_rollover_from_5: assert property (@(posedge clk) (q == 5) |=> (q == 0))
      else $error("Assertion Failed: Counter did not roll over from 5 to 0!");
endmodule

module top_module(
    input clk_100MHz,
    input rst_n,
    output [3:0] q
);
    wire clk_1Hz;

    Clock_divider_100MHz_to_1Hz divider_inst(
        .Clock_1Hz(clk_1Hz),
        .Clock_100MHz(clk_100MHz),
        .Clear_n(rst_n)
    );

    counter_b counter_inst(
        .clk(clk_1Hz),
        .reset_n(rst_n),
        .q(q)
    );
endmodule

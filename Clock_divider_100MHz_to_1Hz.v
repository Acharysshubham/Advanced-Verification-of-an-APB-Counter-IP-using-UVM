module Clock_divider_100MHz_to_1Hz(
    output reg Clock_1Hz,   
    input  Clock_100MHz, Clear_n
);
`ifdef SIMULATION
    localparam MAX_COUNT = 4; // Fast divide for simulation
`else
    localparam MAX_COUNT = 49999999; // Full divide for hardware
`endif

    reg [$clog2(MAX_COUNT+1)-1:0] count;

    always @(posedge Clock_100MHz or negedge Clear_n) begin
        if (!Clear_n) begin
            count <= 0;
            Clock_1Hz <= 0;
        end else if (count == MAX_COUNT) begin
            count <= 0;
            Clock_1Hz <= ~Clock_1Hz;             
        end else begin
            count <= count + 1; 
        end
    end
endmodule

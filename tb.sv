`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
  logic PCLK = 0;
  logic PRESETn;
  always #5 PCLK = ~PCLK; // 100MHz clock

  apb_if apb_vif(PCLK, PRESETn);
  
  wire PREADY_out;

  counter_apb_wrapper dut (
    .PCLK(apb_vif.PCLK),
    .PRESETn(apb_vif.PRESETn),
    .PADDR(apb_vif.PADDR),
    .PSEL(apb_vif.PSEL),
    .PENABLE(apb_vif.PENABLE),
    .PWRITE(apb_vif.PWRITE),
    .PWDATA(apb_vif.PWDATA),
    .PRDATA(apb_vif.PRDATA),
    .PREADY(PREADY_out)
  );

  initial begin
    uvm_config_db#(virtual apb_if)::set(null, "*", "vif", apb_vif);
    run_test("base_test");
  end

  initial begin
    PRESETn = 0;
    repeat(5) @(posedge PCLK);
    PRESETn = 1;
  end
endmodule

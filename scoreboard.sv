`include "uvm_macros.svh"
import uvm_pkg::*;

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  uvm_analysis_imp #(apb_txn, scoreboard) ap_imp;
  logic [3:0] expected_q = 0;
  logic internal_reset = 1;
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    ap_imp = new("ap_imp", this);
  endfunction
  virtual function void write(apb_txn txn);
    if (txn.kind == apb_txn::APB_WRITE && txn.addr == 'h04) begin
      `uvm_info("SCOREBOARD", "Reset control write detected.", UVM_MEDIUM)
      internal_reset = (txn.data[0] == 1);
      if (internal_reset) begin
        expected_q = 0;
      end
    end
    else if (txn.kind == apb_txn::APB_READ && txn.addr == 'h08) begin
      `uvm_info("SCOREBOARD", $sformatf("Count read detected. DUT val: %0d, Expected: %0d", txn.data[3:0], expected_q), UVM_MEDIUM)
      if (txn.data[3:0] != expected_q) begin
        `uvm_error("CHECK_FAIL", $sformatf("Counter value mismatch! DUT=%0d, SB=%0d", txn.data[3:0], expected_q))
      end
      if (!internal_reset) begin
          if (expected_q == 5) begin
              expected_q = 0;
          end else begin
              expected_q++;
          end
      end
    end
  endfunction
endclass

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)
  virtual apb_if vif;
  uvm_analysis_port #(apb_txn) ap;
  function new(string name = "apb_monitor", uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface must be set for apb_monitor")
  endfunction
  virtual task run_phase(uvm_phase phase);
    forever begin
      apb_txn txn = apb_txn::type_id::create("txn");
      @(posedge vif.slave.PCLK);
      wait (vif.slave.PSEL && vif.slave.PENABLE);
      txn.addr = vif.slave.PADDR;
      txn.kind = vif.slave.PWRITE ? apb_txn::APB_WRITE : apb_txn::APB_READ;
      if (txn.kind == apb_txn::APB_WRITE)
        txn.data = vif.slave.PWDATA;
      else
        txn.data = vif.slave.PRDATA;
      ap.write(txn);
    end
  endtask
endclass

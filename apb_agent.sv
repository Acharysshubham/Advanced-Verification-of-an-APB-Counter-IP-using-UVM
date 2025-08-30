`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)
  apb_driver    driver;
  apb_monitor   monitor;
  uvm_sequencer #(apb_txn) sequencer;
  function new(string name = "apb_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = uvm_sequencer#(apb_txn)::type_id::create("sequencer", this);
    driver = apb_driver::type_id::create("driver", this);
    monitor = apb_monitor::type_id::create("monitor", this);
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_driver extends uvm_driver #(apb_txn);
  `uvm_component_utils(apb_driver)
  virtual apb_if vif;
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface must be set for apb_driver")
  endfunction
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive_txn(req);
      seq_item_port.item_done();
    end
  endtask
  virtual task drive_txn(apb_txn txn);
    vif.master.PSEL <= 1'b1;
    vif.master.PWRITE <= (txn.kind == apb_txn::APB_WRITE);
    vif.master.PADDR <= txn.addr;
    vif.master.PWDATA <= txn.data;
    @(posedge vif.master.PCLK);
    vif.master.PENABLE <= 1'b1;
    @(posedge vif.master.PCLK);
    if (txn.kind == apb_txn::APB_READ) begin
        txn.data = vif.master.PRDATA;
    end
    vif.master.PSEL <= 1'b0;
    vif.master.PENABLE <= 1'b0;
  endtask
endclass

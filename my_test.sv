`include "uvm_macros.svh"
import uvm_pkg::*;

class my_sequence extends uvm_sequence #(apb_txn);
  `uvm_object_utils(my_sequence)
  function new(string name = "my_sequence"); super.new(name); endfunction
  
  virtual task body();
    apb_txn req = apb_txn::type_id::create("req");
    
    // 1. Reset the counter via APB write
    start_item(req);
    assert(req.randomize() with { kind == apb_txn::APB_WRITE; addr == 'h04; data[0] == 1; });
    finish_item(req);
    
    // 2. De-assert reset
    start_item(req);
    assert(req.randomize() with { kind == apb_txn::APB_WRITE; addr == 'h04; data[0] == 0; });
    finish_item(req);
    
    // 3. Perform 10 random valid read/write operations
    repeat (10) begin
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
  endtask
endclass

class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  my_env env;
  function new(string name = "base_test", uvm_component parent); super.new(name, parent); endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = my_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    my_sequence seq = my_sequence::type_id::create("seq");
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    #100ns; // Add a final delay to allow last transaction to finish
    phase.drop_objection(this);
  endtask
endclass

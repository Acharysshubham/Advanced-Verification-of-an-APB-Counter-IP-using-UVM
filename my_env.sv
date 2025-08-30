`include "uvm_macros.svh"
import uvm_pkg::*;

class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  apb_agent  agent;
  scoreboard sb;
  function new(string name = "my_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = apb_agent::type_id::create("agent", this);
    sb = scoreboard::type_id::create("sb", this);
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    agent.monitor.ap.connect(sb.ap_imp);
  endfunction
endclass

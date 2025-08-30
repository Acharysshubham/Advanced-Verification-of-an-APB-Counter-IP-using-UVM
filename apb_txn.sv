`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_txn extends uvm_sequence_item;
  `uvm_object_utils(apb_txn)
  typedef enum {APB_READ, APB_WRITE} apb_kind_e;
  rand apb_kind_e  kind;
  rand logic [31:0] addr;
  rand logic [31:0] data;
  constraint valid_addr_c { addr inside {'h00, 'h04, 'h08}; }
  function new(string name = "apb_txn");
    super.new(name);
  endfunction
endclass

#!/bin/bash

# Clean up previous simulation files
rm -rf xcelium.d *.log *.vcd waves.shm

# Compile and run the simulation using Cadence Xcelium
# -sv : Enables SystemVerilog
# -uvmhome CDNS-1.2 : Use the built-in UVM library
# -access +rwc : Allow read/write/connectivity access for debug
# -input run.tcl : Execute the commands in our Tcl script
# -logfile compile.log : Log all output
xrun -sv -uvmhome CDNS-1.2 -access +rwc -input run.tcl -logfile compile.log \
  src/dut/counter_b.v \
  src/dut/Clock_divider_100MHz_to_1Hz.v \
  src/dut/top_module.v \
  src/dut/counter_apb_wrapper.v \
  src/uvm/interface.sv \
  src/uvm/apb_txn.sv \
  src/uvm/apb_driver.sv \
  src/uvm/apb_monitor.sv \
  src/uvm/apb_agent.sv \
  src/uvm/scoreboard.sv \
  src/uvm/my_env.sv \
  src/uvm/my_test.sv \
  src/uvm/tb.sv

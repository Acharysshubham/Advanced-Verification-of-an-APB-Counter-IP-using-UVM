# Advanced-Verification-of-an-APB-Counter-IP-using-UVM


## Overview

This project demonstrates a comprehensive, industry-standard verification environment for a custom IP, built from the ground up. The Design Under Test (DUT) is a simple MOD-6 counter with a clock divider, which has been integrated into a System-on-a-Chip (SoC) context by wrapping it with an **APB (Advanced Peripheral Bus)** slave interface.

The primary goal of this project was to apply modern verification methodologies to rigorously test the IP, find bugs, and ensure functional correctness. The testbench is built using **UVM (Universal Verification Methodology)** in SystemVerilog.

---

## Key Skills & Methodologies Demonstrated

* **Verification Methodology**: UVM, Constrained-Random Verification (CRV), Coverage-Driven Verification
* **Languages**: SystemVerilog, Verilog HDL
* **Assertions**: SystemVerilog Assertions (SVA) for formal property checking
* **SoC Integration**: APB bus protocol, memory-mapped register interface
* **Tools & Simulators**: Cadence Xcelium (on EDA Playground), Verilator, GTKWave
* **Testbench Architecture**: Reusable agent-based structure, transaction-level modeling (TLM), and automated checking with a scoreboard.

---

## Project Structure

```
.
├── src/
│   ├── dut/
│   │   ├── counter_b.v
│   │   ├── Clock_divider_100MHz_to_1Hz.v
│   │   ├── top_module.v
│   │   └── counter_apb_wrapper.v
│   └── uvm/
│       ├── interface.sv
│       ├── apb_txn.sv
│       ├── apb_driver.sv
│       ├── apb_monitor.sv
│       ├── apb_agent.sv
│       ├── scoreboard.sv
│       ├── my_env.sv
│       ├── my_test.sv
│       └── tb.sv
├── README.md
├── requirements.txt
└── run.bash
```

---

## How to Run

This project is designed to be run on **[EDA Playground](https://www.edaplayground.com)**.

1.  **Code Setup**:
    * Copy the contents of all files from `/src/dut` and `/src/uvm` into the **"Design + Testbench"** window on the left.
    * Create a new tab in the "Design + Testbench" window named `run.tcl` and paste the content of `run.tcl` into it.
2.  **Run Script**:
    * Copy the content of `run.bash` into the **"Run"** window on the right.
3.  **Tool Selection**:
    * Select **Cadence Xcelium** as the simulator.
4.  **Execute**:
    * Click "Run". The simulation log will appear, showing the UVM test passing, and a link to the waveform (`dump.vcd`) will be generated.

---

## Results & Impact

The UVM testbench successfully verifies the functionality of the APB-based counter. It automatically generates random APB read/write transactions to the IP's registers and uses a scoreboard to check for correct behavior. The embedded SystemVerilog Assertions provide an additional layer of formal checking.

This project demonstrates an end-to-end verification flow, from block-level design to a complete, automated, and reusable UVM test environment, covering all major skills required for a modern Design Verification role.

interface apb_if(input PCLK, PRESETn);
  logic [31:0] PADDR;
  logic        PSEL;
  logic        PENABLE;
  logic        PWRITE;
  logic [31:0] PWDATA;
  logic [31:0] PRDATA;
  logic        PREADY;

  modport master (output PADDR, PSEL, PENABLE, PWRITE, PWDATA, input  PRDATA, PREADY, PCLK, PRESETn);
  modport slave (input PADDR, PSEL, PENABLE, PWRITE, PWDATA, PRDATA, PREADY, PCLK, PRESETn);
endinterface

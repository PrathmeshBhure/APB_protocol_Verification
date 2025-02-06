// Code your testbench here
// or browse Examples


`include"uvm_macros.svh"
import uvm_pkg::*;

`include"apb_pkg.sv"
import apb_pkg::*;

`include"apb_interface.sv"
module tb_top;
  
  logic pclk;
  logic presetn;
  parameter PCLK_PRD=5;
  parameter PRST_PRD=4;
 
  
  apb_intf intf(pclk,presetn);
  apb_ram i_slave_dut(.pclk(pclk),.presetn(presetn),.psel(intf.psel),.paddr(intf.paddr),.pwrite(intf.pwrite),.pwdata(intf.pwdata),.pready(intf.pready),.prdata(intf.prdata),.pslverr(intf.pslverr),.penable(intf.penable));
  
  //task for clk generation
  task clk_gen();
    pclk=0;
    forever begin
    #(PCLK_PRD/2)pclk=~pclk;
    end
  endtask
  
  //task for reset generation
  task rst_gen();
   // preset=1;
  //  #PRST_PRD;
    presetn=1;
    #(PRST_PRD);
    presetn=0;
    #(PRST_PRD);
     presetn=1;
  endtask
  
  //clk gen
  initial begin
    clk_gen();
  end
  
  //reset gen
  initial begin
    rst_gen();
  end
  
  initial begin
    uvm_config_db #(virtual apb_intf)::set(null,"*","intf1",intf);
    run_test("apb_test");
  end
  
  initial begin
    $dumpfile("dump.vcd");
      $dumpvars;
  end
  
  initial begin
    #800;
    $finish;
  end
  
 
endmodule
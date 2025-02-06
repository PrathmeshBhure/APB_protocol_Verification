class apb_cov_collector extends uvm_subscriber#(apb_seq_item);
  `uvm_component_utils(apb_cov_collector)
   apb_seq_item h_item;
  
  
  covergroup cg_apb;
    cp_pwrite: coverpoint h_item.pwrite{bins b1[2]={[0:1]};}
    cp_sel: coverpoint h_item.psel{bins b9[2]={[0:1]};}
    cp_pready: coverpoint h_item.pready{bins b2[2]={[0:1]};}
    cp_pwdata: coverpoint h_item.pwdata{bins b3[7]={[0:32'hffffffff]};}
    cp_prdata: coverpoint h_item.prdata{bins b4[7]={[0:32'hffffffff]};}
    cp_paddr: coverpoint h_item.paddr{bins b5[1]={[0:31]};}
    cp_penable: coverpoint h_item.penable{bins b6[2]={[0:1]};}
    cp_pslverr: coverpoint h_item.pslverr{bins b7[1]={[0:1]};}
  endgroup
  
  function new(string name="apb_cov_collector",uvm_component parent);
    super.new(name,parent);
    `uvm_info("APB_COV_COLLECTOR ","Inside APB_COV_COLLECTOR  NEW",UVM_MEDIUM)
    cg_apb=new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("APB_COV_COLLECTOR ","Inside APB_COV_COLLECTOR BUILD PHASE",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("APB_COV_COLLECTOR ","Inside APB_COV_COLLECTOR CONNECT PHASE",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("APB_COV_COLLECTOR ","Inside APB_COV_COLLECTOR  RUN PHASE",UVM_MEDIUM)
  endtask
  
  virtual function void write(apb_seq_item t);
   h_item=t;
    cg_apb.sample();
    `uvm_info("coverage_collector",$sformatf("the functional coverage is:%d",cg_apb.get_coverage),UVM_MEDIUM)
    `uvm_info("APB_COV_COLLECTOR ","Inside APB_COV_COLLECTOR  RUN PHASE",UVM_MEDIUM)
  endfunction
  
endclass
class master_vseqr extends uvm_sequencer;
  `uvm_component_utils(master_vseqr)
  master_seqr h_seqr;
  
  function new(string name="master_vseqr",uvm_component parent);
    super.new(name,parent);
    `uvm_info("MASTER_VSEQR ","Inside MASTER_VSEQR new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
    h_seqr=master_seqr::type_id::create("h_seqr",this);
  endtask
  
endclass
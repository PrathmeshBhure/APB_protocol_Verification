class master_seqr extends uvm_sequencer #(apb_seq_item);
  `uvm_component_utils(master_seqr)
 // `uvm_declare_p_sequencer(master_vseqr);
  
  function new(string name="master_seqr",uvm_component parent);
    super.new(name,parent);
    `uvm_info("MASTER_SEQr ","Inside MASTER_SEQR NEW",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MASTER_SEQr ","Inside MASTER_SEQR BUILD PHASE",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MASTER_SEQr ","Inside MASTER_SEQR CONNECT PHASE",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MASTER_SEQr ","Inside MASTER_SEQR RUN PHASE",UVM_MEDIUM)
  endtask
  
endclass
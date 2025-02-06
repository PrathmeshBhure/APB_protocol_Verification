class apb_vseq extends uvm_sequence;
  `uvm_object_utils(apb_vseq)
  `uvm_declare_p_sequencer(master_vseqr)
  apb_seq h_apb_seq;
  mul_wr_seq h_mul_wr_seq;
  mul_rd_seq h_mul_rd_seq;
  alt_wr_rd_seq h_alt_wr_rd_seq;
 // check_slverr_seq h_check_slverr_seq;
  function new(string name="apb_vseq");
    super.new(name);
    `uvm_info("APB_VSEQ ","Inside APB_VSEQ new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
    h_apb_seq = apb_seq :: type_id :: create("h_apb_seq");
    h_apb_seq.start(p_sequencer.h_seqr);
    
    h_mul_wr_seq = mul_wr_seq :: type_id :: create("h_mul_wr_seq");
    h_mul_wr_seq.start(p_sequencer.h_seqr);
    
    h_mul_rd_seq = mul_rd_seq :: type_id :: create("h_mul_rd_seq");
    h_mul_rd_seq.start(p_sequencer.h_seqr);
    
    
    h_alt_wr_rd_seq = alt_wr_rd_seq :: type_id :: create("h_alt_wr_rd_seq");
    h_alt_wr_rd_seq.start(p_sequencer.h_seqr);
    
     
//     h_check_slverr_seq = check_slverr_seq :: type_id :: create("h_check_slverr_seq");
//     h_check_slverr_seq.start(p_sequencer.h_seqr);
    
  endtask
  
endclass
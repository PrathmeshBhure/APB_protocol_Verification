class apb_seq_item extends uvm_sequence_item;
  
// `uvm_object_utils(apb_seq_item)
       bit [31:0] paddr;
       bit psel;
       bit penable;
       bit pwrite;
       rand bit [31:0] pwdata;
       bit pready;
       bit  [31:0] prdata;
       bit  pslverr;
  
 // constraint c1{pwdata<250; pwdata>0;}
  
  `uvm_object_utils_begin(apb_seq_item)
  `uvm_field_int(paddr, UVM_ALL_ON)
  `uvm_field_int(psel, UVM_ALL_ON)
  `uvm_field_int(penable, UVM_ALL_ON)
  `uvm_field_int(pwrite, UVM_ALL_ON)
  `uvm_field_int(pwdata, UVM_ALL_ON)
  `uvm_field_int(prdata, UVM_ALL_ON)
  `uvm_field_int(pslverr, UVM_ALL_ON)
  `uvm_field_int(pready, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "apb_seq_item");
    super.new(name);
    `uvm_info("APB_SEQ_ITEM","Inside APB_ SEQ_item NEW ",UVM_MEDIUM)
  endfunction
  
  
endclass
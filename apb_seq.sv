 //**********************************Single write read sequnece*************************************************
class apb_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(apb_seq)
  apb_seq_item h_item;
  
  function new(string name="apb_seq");
    super.new(name);
    `uvm_info("APB_SEQ ","Inside APB_SEQ new",UVM_MEDIUM)
  endfunction
  
 virtual task body();
    single_wr();
   // #10;
    single_rd(); 
  endtask
  
    virtual task single_wr(); 
      h_item = apb_seq_item:: type_id::create("h_item");
      start_item(h_item);
      h_item.pwrite=1;
      h_item.paddr = 5;
      h_item.pwdata=30;
      finish_item(h_item);
   //  #10;
      `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
      h_item.print();
     `uvm_info("APB_SEQ ","Inside APB_SEQ BODY",UVM_MEDIUM)
  endtask
  
  virtual task single_rd(); 
    start_item(h_item);
    h_item.pwrite=0;
    h_item.paddr = 5;
      `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
      finish_item(h_item);
      h_item.print();
  endtask 
  
endclass

//**********************************Multiple write sequnece*************************************************

class mul_wr_seq extends apb_seq;
  `uvm_object_utils(mul_wr_seq)
  apb_seq_item h_item;
  
  function new(string name="mul_wr_seq");
    super.new(name);
    `uvm_info("mul_wr_seq ","Inside mul_wr new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
  //  #10;
     h_item = apb_seq_item:: type_id::create("h_item");
    repeat(10) begin
    single_wr();
    end
  endtask
  
  virtual task single_wr(); 
      start_item(h_item);
      h_item.pwrite=1;
      h_item.paddr= h_item.paddr +1;
      assert(h_item.randomize());
    // #10;
      `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
      finish_item(h_item);
      h_item.print();
     `uvm_info("APB_SEQ ","Inside APB_SEQ BODY",UVM_MEDIUM)
  endtask  
 
endclass

//**********************************Multiple read sequnece*************************************************

class mul_rd_seq extends apb_seq;
  `uvm_object_utils(mul_rd_seq)
  apb_seq_item h_item;
  
  function new(string name="mul_rd_seq");
    super.new(name);
    `uvm_info("mul_rd_seq ","Inside mul_rd new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
     h_item = apb_seq_item:: type_id::create("h_item");
  //  #10;
    repeat(10) begin
   single_rd();
   // #10;
    end
  endtask
  
  virtual task single_rd(); 
    start_item(h_item);
    h_item.pwrite=0;
    h_item.paddr= h_item.paddr +1;
      `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
      finish_item(h_item);
      h_item.print();
  endtask
  
endclass

//**********************************Alternate write read sequnece*************************************************

class alt_wr_rd_seq extends apb_seq; 
  `uvm_object_utils(alt_wr_rd_seq)
  apb_seq_item h_item;
  int i=10;
  int j=10;
  
  function new(string name="mul_rd_seq");
    super.new(name);
    `uvm_info("alt_wr_rd_seq ","Inside mul_rd new",UVM_MEDIUM)
  endfunction
  
  virtual task body();
    
    repeat(5) begin
    single_wr();
     
    single_rd();
   // #10;
    end
  endtask
  
 virtual task single_wr();
        h_item = apb_seq_item:: type_id::create("h_item");
      start_item(h_item);
      h_item.pwrite=1;
      h_item.paddr= i++;
      assert(h_item.randomize());
    // #10;
      `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
      finish_item(h_item);
      h_item.print();
     `uvm_info("APB_SEQ ","Inside APB_SEQ BODY",UVM_MEDIUM)
  endtask  
 
   
  virtual task single_rd(); 
  h_item = apb_seq_item:: type_id::create("h_item");
    start_item(h_item);
    h_item.pwrite=0;
    h_item.paddr= j++;
      `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
      finish_item(h_item);
      h_item.print();
  endtask
  
endclass


// class check_slverr_seq extends apb_seq;
//   `uvm_object_utils(check_slverr_seq)
//   apb_seq_item h_item;
  
//   function new(string name="mul_wr_seq");
//     super.new(name);
//     `uvm_info("mul_wr_seq ","Inside mul_wr new",UVM_MEDIUM)
//   endfunction
  
//   virtual task body();
//   //  #10;
//      h_item = apb_seq_item:: type_id::create("h_item");
//     repeat(2) begin
//     single_wr();
//     end
//     repeat(2) begin
//       single_rd();
//     end
//   endtask
  
//   virtual task single_wr(); 
//       start_item(h_item);
//       h_item.pwrite=1;
//       h_item.paddr=40;
//       assert(h_item.randomize());
//     // #10;
//       `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
//       finish_item(h_item);
//       h_item.print();
//      `uvm_info("APB_SEQ ","Inside APB_SEQ BODY",UVM_MEDIUM)
//   endtask  
  
    
//   virtual task single_rd(); 
//   h_item = apb_seq_item:: type_id::create("h_item");
//     start_item(h_item);
//     h_item.pwrite=0;
//     h_item.paddr= 40;
//       `uvm_info("apb__seq",$sformatf("Done generation in sequence => %s items",h_item.sprint()),UVM_MEDIUM)
//       finish_item(h_item);
//       h_item.print();
//   endtask
 
// endclass
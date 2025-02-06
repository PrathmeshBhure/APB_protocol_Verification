class master_driver extends uvm_driver#(apb_seq_item);
  `uvm_component_utils(master_driver)
   virtual apb_intf vif;
   apb_seq_item  h_item;
  function new(string name="master_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Master_Driver","Inside Master_Driver Build Phase ",UVM_MEDIUM)
    if(!uvm_config_db#(virtual apb_intf)::get(this,"","intf1",vif)) begin
      `uvm_fatal("Matser_driver","virtual intf instance not collected properly")
    end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // wait(vif.presetn == 1);
         idle_state();
        forever begin
        @(posedge vif.pclk);
          seq_item_port.get_next_item(h_item);
           drive_transfer(h_item);
         
           setup_state();
           access_state();
          
          `uvm_info("APB_Driver",$sformatf("Packet in driver => %s items",h_item.sprint()),UVM_MEDIUM)
            seq_item_port.item_done();
//          
        end
  endtask
  
  
   
  task drive_transfer(apb_seq_item h_item);
     
   
     vif.pwrite<= h_item.pwrite;        
     vif.pwdata<= h_item.pwdata;
     vif.paddr<= h_item.paddr;

  endtask
  

  
  task idle_state();
    @(posedge vif.pclk);
    vif.psel<='b0;
    vif.penable<='b0;
  endtask
  
  task setup_state();
    @(posedge vif.pclk);
    vif.psel <= 1;
    vif.penable <= 0;
  endtask
  
  task access_state();
    @(posedge vif.pclk);
    vif.psel <= 1;
    vif.penable<= 1;
  endtask
  
endclass
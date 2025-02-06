class master_monitor extends uvm_monitor;
  `uvm_component_utils(master_monitor)
   apb_seq_item h_item;
   virtual apb_intf vif;
  uvm_analysis_port#(apb_seq_item)  master_mon2scbd;
  
  function new(string name="master_monitor",uvm_component parent);
    super.new(name,parent);
    `uvm_info("MASTER_MONITOR ","Inside MASTER_MONITOR NEW",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    master_mon2scbd = new("master_mon2scbd",this);
    if(!uvm_config_db#(virtual apb_intf)::get(this,"","intf1",vif)) begin
      `uvm_fatal("ip_driver","virtual intf instance not collected properly")
     end
    `uvm_info("MASTER_MONITOR ","Inside MASTER_AMONITORBUILD PHASE",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MASTER_MONITOR ","Inside MASTER_MONITOR CONNECT PHASE",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MASTER_MONITOR ","Inside MASTER_MONITOR RUN PHASE",UVM_MEDIUM)
    
     forever begin
       @(posedge vif.pclk); 
       if(vif.presetn==1 && vif.pwrite==1  && vif.paddr >0) begin
       
       
       h_item=apb_seq_item::type_id::create("h_item");
       h_item.pwdata=vif.pwdata;
       h_item.pwrite=vif.pwrite;
       h_item.paddr=vif.paddr;
       h_item.psel=vif.psel; 
       h_item.penable=vif.penable; 
       `uvm_info("MASTER_MONITOR",$sformatf("Packet in master_monitor => %s items",h_item.sprint()),UVM_MEDIUM)
      //analysis port to scoreboard
      master_mon2scbd.write(h_item);
      end
    end
    
  endtask
endclass
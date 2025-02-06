class slave_monitor extends uvm_monitor;
  `uvm_component_utils(slave_monitor)
   apb_seq_item h_item;
   virtual apb_intf vif;
  uvm_analysis_port#(apb_seq_item)  slave_mon2scbd;
  function new(string name="slave_monitor",uvm_component parent);
    super.new(name,parent);
    `uvm_info("SLAVE_MONITOR ","Inside SLAVE_MONITOR NEW",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slave_mon2scbd = new("slave_mon2scbd",this);
    `uvm_info("SLAVE_MONITOR ","Inside SLAVE_MONITOR BUILD PHASE",UVM_MEDIUM)
    
     if(!uvm_config_db#(virtual apb_intf)::get(this,"","intf1",vif)) begin
       `uvm_fatal("slave_monitor","virtual intf instance not collected properly")
     end
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SLAVE_MONITOR ","Inside SLAVE_MONITOR CONNECT PHASE",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SLAVE_MONITOR ","Inside SLAVE_MONITOR RUN PHASE",UVM_MEDIUM)
     forever begin
        @(posedge vif.pclk); 
       if(vif.presetn == 1 && vif.pwrite==0  && vif.paddr >0 )
       begin 
      
       
       h_item=apb_seq_item::type_id::create("h_item");
       h_item.prdata=vif.prdata;
      h_item.pslverr=vif.pslverr;
      h_item.pready=vif.pready;
         `uvm_info("slave_MONITOR",$sformatf("Packet in slave_monitor => %s items",h_item.sprint()),UVM_MEDIUM)
      //analysis port to scoreboard
      slave_mon2scbd.write(h_item);
      end
      end
    

  
  endtask
  
  
  

endclass
class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)
  master_seqr h_seqr;
  master_driver h_driv;
  master_monitor h_master_mon;
  master_agent_config h_master_agent_config;
  
  
  function new(string name="master_agent",uvm_component parent);
    super.new(name,parent);
    `uvm_info("MASTER_AGENT ","Inside MASTER_AGENT NEW",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    
    if(!uvm_config_db#(master_agent_config)::get(this,"","master_agent_config",h_master_agent_config)) begin
      `uvm_fatal("master agent","master agent config not collected properly")
		end

    if(h_master_agent_config.has_master_monitor == 1) begin
		  h_master_mon= master_monitor::type_id::create("h_master_mon",this);
	        end

    if(h_master_agent_config.has_master_seqr == 1) begin
		 h_seqr=master_seqr::type_id::create("h_seqr",this);
        end 
    
    if(h_master_agent_config.has_master_driver == 1) begin
		h_driv= master_driver::type_id::create("h_driv",this);
        end 
    
   
    `uvm_info("MASTER_AGENT ","Inside MASTER_AGENT BUILD PHASE",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MASTER_AGENT ","Inside MASTER_AGENT CONNECT PHASE",UVM_MEDIUM)
    h_driv.seq_item_port.connect(h_seqr.seq_item_export);
    
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MASTER_AGENT ","Inside MASTER_AGENT RUN PHASE",UVM_MEDIUM)
  endtask
  
endclass
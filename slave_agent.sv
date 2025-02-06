class slave_agent extends uvm_agent;
  `uvm_component_utils(slave_agent)
   slave_monitor h_slave_mon;
   slave_agent_config h_slave_agent_config;
  
  function new(string name="slave_agent",uvm_component parent);
    super.new(name,parent);
    `uvm_info("SLAVE_AGENT ","Inside SLAVE_AGENT NEW",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  
    `uvm_info("SLAVE_AGENT ","Inside SLAVE_AGENT BUILD PHASE",UVM_MEDIUM)
    
    if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",h_slave_agent_config)) begin
      `uvm_fatal("slave_agent","slave agent config not collected properly")
		end

      if(h_slave_agent_config.has_slave_monitor == 1) begin
		   h_slave_mon= slave_monitor::type_id::create("h_slave_mon",this);
	        end

  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SLAVE_AGENT ","Inside SLAVE_AGENT CONNECT PHASE",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SLAVE_AGENT ","Inside SLAVE_AGENT RUN PHASE",UVM_MEDIUM)
  endtask
  
endclass
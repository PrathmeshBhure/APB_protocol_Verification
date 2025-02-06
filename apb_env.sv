class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
   master_vseqr h_vseqr;
   master_agent		h_master_agent;
   slave_agent		h_slave_agent;
   apb_scoreboard	h_scbd;
  apb_cov_collector h_cov;
  env_config h_env_cfg;
  function new(string name="apb_env",uvm_component parent);
    super.new(name,parent);
    `uvm_info("APB_ENV ","Inside APB_ENV new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
   
    h_scbd= apb_scoreboard::type_id::create("h_scbd",this);
    h_vseqr= master_vseqr::type_id::create("h_vseqr",this);
    h_cov =apb_cov_collector::type_id::create("h_cov",this);
    `uvm_info("APB_ENV ","Inside APB_ENV Build Phase",UVM_MEDIUM)
    
    if(!uvm_config_db#(env_config)::get(this,"","env_config",h_env_cfg)) begin
			`uvm_fatal("env","env config not collected properly")
		end

		h_env_cfg.build_configs();

		if(h_env_cfg.has_master_agent == 1) begin
		 h_master_agent= master_agent::type_id::create("h_master_agent",this);
	        end

		if(h_env_cfg.has_slave_agent == 1) begin
		 h_slave_agent= slave_agent::type_id::create("h_slave_agent",this);
        end 
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("APB_ENV ","Inside APB_ENV Connect phase",UVM_MEDIUM)
     h_vseqr.h_seqr = h_master_agent.h_seqr;
    h_master_agent.h_master_mon.master_mon2scbd.connect(h_scbd.master_mon2sb_imp_port);
    h_slave_agent.h_slave_mon.slave_mon2scbd.connect(h_scbd.slave_mon2sb_imp_port);
    
    h_master_agent.h_master_mon.master_mon2scbd.connect(h_cov.analysis_export);
    h_slave_agent.h_slave_mon.slave_mon2scbd.connect(h_cov.analysis_export);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("APB_ENV ","Inside APB_ENV Run phase",UVM_MEDIUM)
  endtask
  
endclass
class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  apb_env h_env;
  apb_seq h_seq;
  apb_vseq h_vseq;
  env_config h_env_config;
  master_agent_config h_master_agent_config;
  slave_agent_config h_slave_agent_config;
  
  function new(string name="apb_test",uvm_component parent);
    super.new(name,parent);
    `uvm_info("APB_TEST ","Inside APB_Test new ",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    h_env= apb_env::type_id::create("h_env",this);
    h_seq= apb_seq::type_id::create("h_seq");
    h_vseq= apb_vseq::type_id::create("h_vseq");
      h_env_config= env_config::type_id::create("h_env_config");
      h_master_agent_config= master_agent_config::type_id::create(" h_master_agent_config");
      h_slave_agent_config=  slave_agent_config::type_id::create(" h_slave_agent_config");
    
    `uvm_info("APB_TEST ","Inside APB_Test Build Phase",UVM_MEDIUM)
    
    uvm_config_db#(env_config)::set(this,"*","env_config",h_env_config);   
    
    uvm_config_db#(master_agent_config)::set(this,"*","master_agent_config",h_master_agent_config); 
    
    uvm_config_db#(slave_agent_config)::set(this,"*","slave_agent_config",h_slave_agent_config);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("APB_TEST ","Inside APB_Test Connect Phase",UVM_MEDIUM)
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
    `uvm_info("APB_TEST ","Inside APB_Test end_of_elaboration Phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("APB_Test ","InsideAPB_ Test Run Phase",UVM_MEDIUM)
    phase.raise_objection(this);
    // start vseq on vseqr //
      h_vseq.start(h_env.h_vseqr);
    #50;
    phase.drop_objection(this);
  endtask
  
endclass
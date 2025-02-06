class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
   // DECLARATION
  `uvm_analysis_imp_decl(_ip_imp)
  `uvm_analysis_imp_decl(_op_imp)
 // apb_seq_item h_item;
   // IMPLEMENTATION
  uvm_analysis_imp_ip_imp #(apb_seq_item,apb_scoreboard) master_mon2sb_imp_port;
  uvm_analysis_imp_op_imp #(apb_seq_item,apb_scoreboard) slave_mon2sb_imp_port;
  apb_seq_item ip_queue[$];
  apb_seq_item op_queue[$];
  apb_seq_item h_item;
  apb_seq_item act_data;
  apb_seq_item exp_data;
  
  int pass_count=0;
  int fail_count=0;
  
  function new(string name="apb_scoreboard",uvm_component parent);
    super.new(name,parent);
    `uvm_info("APB_Scoreboard ","Inside apb_scoreboard NEW",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    master_mon2sb_imp_port = new("master_mon2sb_imp_port",this);
    slave_mon2sb_imp_port = new("slave_mon2sb_imp_port",this);
    `uvm_info("APB_Scoreboard ","Inside apb_scoreboard Build Phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("APB_Scoreboard ","Inside apb_scoreboard CONNECT Phase",UVM_MEDIUM)
  endfunction
  
  function void write_ip_imp(apb_seq_item h_item);
     
    int a;
    a=h_item.pwdata;
  //  $display("a=%0d",a);
   ip_queue.push_back(h_item);
  endfunction
  
  function void write_op_imp(apb_seq_item h_item);
    if(h_item.prdata>0)
      begin
 
    op_queue.push_back(h_item);
      end
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("APB_Scoreboard ","Inside apb_scoreboard RUN Phase",UVM_MEDIUM)
     forever begin
      compare();
    end
  endtask
  
  
  virtual task compare();
    act_data=new();
    exp_data=new();
    wait(ip_queue.size() > 0 );
    wait(op_queue.size() > 0 );
    act_data = op_queue.pop_front();
    exp_data = ip_queue.pop_front();
    if(exp_data.pwdata == act_data.prdata)begin
      pass_count++;
      `uvm_info("COMPARE",$sformatf("PASSED,At time :%0t___exp_data = %0d is MATCHED with act_data = %0d\n",$time,exp_data.pwdata,act_data.prdata),UVM_LOW)
    end
    else begin
      fail_count++;
      `uvm_info("COMPARE",$sformatf("FAILED,At time :%0t___exp_data = %0d is NOT  MATCHED with act_data = %0d\n",$time,exp_data.pwdata,act_data.prdata),UVM_LOW)
    end
    if(exp_data.paddr>32 && act_data.pslverr==1)begin
      pass_count++;
    end
  endtask
  
  virtual function void report_phase(uvm_phase phase);
    `uvm_info("REPORT PHASE",$sformatf("Scoreboard results: Passed=%0d, Failed=%0d",pass_count,fail_count),UVM_NONE)
    if (fail_count<pass_count)begin
      `uvm_info("REPORT PHASE",$sformatf("Test Passed with %0d matched",pass_count),UVM_LOW)
    end
    else begin
      `uvm_error("REPORT PHASE",$sformatf("Test FAILED with %0d data not  matched",fail_count))
    end
  endfunction 
endclass
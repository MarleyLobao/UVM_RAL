class traffic_reg_ro_backdoor_test extends traffic_base_test;
  `uvm_component_utils (traffic_reg_ro_backdoor_test)
 
  function new (string name="traffic_reg_ro_backdoor_test", uvm_component parent);
    super.new (name, parent);
  endfunction
 
  virtual task main_phase(uvm_phase phase);
    ral_reg_block_sys m_reg_sys;
    uvm_status_e      status;
    int               rdata, wdata;
 
    phase.raise_objection(this);

    `ifdef BACKDOOR_MODE
      m_apb_env.m_reg_env.set_report_verbosity_level (UVM_HIGH);
      if(! uvm_config_db#(ral_reg_block_sys)::get(null, "uvm_test_top", "reg_sys", m_reg_sys))
      `uvm_fatal ("VIF", "No vif")
    
      // Write a value without respecting access rights
      // Reads a value while respecting access rights
      wdata = 2'b01;
      m_reg_sys.cfg.state.poke (status, wdata);
      m_reg_sys.cfg.state.read (status, rdata);
      `uvm_info({"POKE-READ: ", get_type_name()}, $sformatf("wdata=0x%0h rdata=0x%0h", wdata, rdata), UVM_MEDIUM)

      // Write a value while respecting access rights
      // Reads a value without respecting access rights
      wdata = 2'b10;
      m_reg_sys.cfg.state.write (status, wdata);
      m_reg_sys.cfg.state.peek  (status, rdata);
      `uvm_info({"WRITE-PEEK: ", get_type_name()}, $sformatf("wdata=0x%0h rdata=0x%0h", wdata, rdata), UVM_MEDIUM)
    `endif
 
    phase.drop_objection(this);
  endtask
 
   virtual task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     phase.raise_objection(this);
     #100ns;
     phase.drop_objection(this);
   endtask
 endclass

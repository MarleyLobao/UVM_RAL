class traffic_reg_rw_backdoor_test extends traffic_base_test;
   `uvm_component_utils (traffic_reg_rw_backdoor_test)

   function new (string name="traffic_reg_rw_backdoor_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual task main_phase(uvm_phase phase);
      ral_reg_block_sys m_reg_sys;
      uvm_status_e      status;
      int               rdata;

      phase.raise_objection(this);

      `ifdef BACKDOOR_MODE
        m_apb_env.m_reg_env.set_report_verbosity_level (UVM_HIGH);
        if(! uvm_config_db#(ral_reg_block_sys)::get(null, "uvm_test_top", "reg_sys", m_reg_sys))
           `uvm_fatal ("VIF", "No vif")
      
        // Perform a normal frontdoor access -> write some data first and then read it back
        m_reg_sys.cfg.timer[1].write (status, 32'h1234_5678);
        m_reg_sys.cfg.timer[1].read (status, rdata);
        `uvm_info(get_type_name(), $sformatf("desired=0x%0h mirrored=0x%0h", m_reg_sys.cfg.timer[1].get(), m_reg_sys.cfg.timer[1].get_mirrored_value()), UVM_MEDIUM)
      
        // Perform a backdoor access for write and then do a frontdoor read 
        m_reg_sys.cfg.timer[1].write(status, 32'ha5a5_a5a5, UVM_BACKDOOR);
        m_reg_sys.cfg.timer[1].read(status, rdata);
        `uvm_info(get_type_name(), $sformatf("desired=0x%0h mirrored=0x%0h", m_reg_sys.cfg.timer[1].get(), m_reg_sys.cfg.timer[1].get_mirrored_value()), UVM_MEDIUM)
      
        // Perform a frontdoor write and then do a backdoor read
        m_reg_sys.cfg.timer[1].write(status, 32'hface_face);
        // Wait for a time unit so that backdoor access reads update value
        #1;  
        m_reg_sys.cfg.timer[1].read(status, rdata, UVM_BACKDOOR);
        `uvm_info(get_type_name(), $sformatf("desired=0x%0h mirrored=0x%0h", m_reg_sys.cfg.timer[1].get(), m_reg_sys.cfg.timer[1].get_mirrored_value()), UVM_MEDIUM)
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

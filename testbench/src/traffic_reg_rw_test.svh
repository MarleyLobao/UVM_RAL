class traffic_reg_rw_test extends traffic_base_test;
   `uvm_component_utils (traffic_reg_rw_test)

   function new (string name="traffic_reg_rw_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   // Note that main_phase comes after reset_phase, and is performed when
   // DUT is out of reset. "reset_phase" is already defined in traffic_base_test
   // and is always called when this test is started
   virtual task main_phase(uvm_phase phase);
      ral_reg_block_sys m_reg_sys;
      uvm_status_e      status;
      int               rdata;

      phase.raise_objection(this);

      m_apb_env.m_reg_env.set_report_verbosity_level (UVM_HIGH);
      
      // Get register model from config_db
      if(! uvm_config_db#(ral_reg_block_sys)::get(null, "uvm_test_top", "reg_sys", m_reg_sys))
         `uvm_fatal ("VIF", "No vif")
      
      // Write 0xcafe_feed to the timer[1] register, and read it back
      m_reg_sys.cfg.timer[1].write (status, 32'hcafe_feed);
      m_reg_sys.cfg.timer[1].read (status, rdata);
      
      // Set 0xface as the desired value for timer[1] register
      m_reg_sys.cfg.timer[1].set(32'hface);
      `uvm_info(get_type_name(), $sformatf("desired=0x%0h mirrored=0x%0h", m_reg_sys.cfg.timer[1].get(), m_reg_sys.cfg.timer[1].get_mirrored_value()), UVM_MEDIUM)
      
      // Predict that current value of timer[1] is 0xcafe_feed and check it is true
      m_reg_sys.cfg.timer[1].predict(32'hcafe_feed);
      m_reg_sys.cfg.timer[1].mirror(status, UVM_CHECK);
      
      // Set desired value of the field "bl_yellow" in register ctrl to 1
      // Then start bus transactions by calling "update" to update DUT with 
      // desired value
      m_reg_sys.cfg.ctrl.bl_yellow.set(1);
      m_reg_sys.cfg.update(status);

	  // Attempt to write into a RO register "stat" with some value
      m_reg_sys.cfg.state.write(status, 32'h12345678);
      phase.drop_objection(this);
   endtask

  // Before end of simulation, allow some time for unfinished transactions to
  // be over
  virtual task shutdown_phase(uvm_phase phase);
    super.shutdown_phase(phase);
    phase.raise_objection(this);
    #100ns;
    phase.drop_objection(this);
  endtask
endclass

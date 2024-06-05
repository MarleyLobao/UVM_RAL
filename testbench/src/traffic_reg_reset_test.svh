class traffic_reg_reset_test extends traffic_base_test;
   `uvm_component_utils (traffic_reg_reset_test)

   uvm_reg_hw_reset_seq rst_seq;

   function new (string name="traffic_reg_reset_test", uvm_component parent);
      super.new (name, parent);

      rst_seq = uvm_reg_hw_reset_seq::type_id::create("rst_seq");
   endfunction

   virtual task post_reset_phase(uvm_phase phase);
      ral_reg_block_sys m_reg_sys;

      phase.raise_objection(this);

      m_apb_env.m_reg_env.set_report_verbosity_level (UVM_HIGH);
      
      // Get register model from config_db
      if(! uvm_config_db#(ral_reg_block_sys)::get(null, "uvm_test_top", "reg_sys", m_reg_sys))
         `uvm_fatal ("VIF", "No vif")

      rst_seq.model = m_reg_sys;
      rst_seq.start(null);
      
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
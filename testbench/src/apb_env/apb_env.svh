class apb_env extends uvm_env;
   `uvm_component_utils (apb_env)
   
   apb_agent m_agent;   
   ral_reg_env m_reg_env;
   
   function new (string name = "apb_env", uvm_component parent);
      super.new (name, parent);
   endfunction
   
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_agent = apb_agent::type_id::create ("m_agent", this);
      m_reg_env   = ral_reg_env::type_id::create ("m_reg_env", this);
      uvm_reg::include_coverage ("*", UVM_CVR_ALL);
   endfunction

   // Connect analysis port of monitor with predictor, assign agent to register env
   // and set default map of the register env
   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      m_agent.m_mon.mon_ap.connect (m_reg_env.m_apb2reg_predictor.bus_in);
      m_reg_env.m_ral_model.default_map.set_sequencer(m_agent.m_seqr, m_reg_env.m_reg2apb);
   endfunction
   
endclass

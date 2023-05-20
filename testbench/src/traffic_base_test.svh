class traffic_base_test extends uvm_test;
   `uvm_component_utils (traffic_base_test)

   apb_env             m_apb_env;
   apb_reset_sequence  m_apb_reset_sequence;
   uvm_status_e        status;

   function new (string name = "traffic_base_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   // Build the testbench environment, and sequence
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_apb_env = apb_env::type_id::create ("m_apb_env", this);
      m_apb_reset_sequence = apb_reset_sequence::type_id::create ("m_apb_reset_sequence", this);
   endfunction
 
   // In the reset phase, apply reset
   virtual task reset_phase (uvm_phase phase);
      super.reset_phase (phase);
      phase.raise_objection (this);
      m_apb_reset_sequence.start (m_apb_env.m_agent.m_seqr);
      phase.drop_objection (this);
   endtask
endclass

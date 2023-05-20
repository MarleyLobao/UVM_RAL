class apb_reset_sequence extends uvm_sequence;
   `uvm_object_utils (apb_reset_sequence)
   function new (string name = "apb_reset_sequence");
      super.new (name);
   endfunction

   virtual apb_if vif_sequence; 

   task body ();
      if (!uvm_config_db #(virtual apb_if) :: get (null, "uvm_test_top.*", "vif", vif_sequence)) 
         `uvm_fatal ("VIF", "No vif")

      `uvm_info ("RESET", "Running reset ...", UVM_MEDIUM);
      vif_sequence.presetn <= 0;
      @(posedge vif_sequence.pclk) vif_sequence.presetn <= 1;
      @ (posedge vif_sequence.pclk);
   endtask
endclass
